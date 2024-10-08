# Edge App - Mosquitto MQTT Broker

The **Edge App - Mosquitto MQTT Broker** for SecureEdge Pro provides a lightweight and reliable MQTT broker solution for secure and efficient message exchange between IoT devices. This application facilitates seamless communication between industrial devices and cloud platforms by acting as a central hub for message routing, enabling real-time data collection, remote monitoring, and control. It supports easy configuration, high scalability, and reliable messaging, making it an essential component for any IoT or industrial automation setup

## Prerequisites

Ensure your environment is properly set up by following this guide: [Running custom Docker applications on the SecureEdge Pro](https://support.ixon.cloud/hc/en-us/articles/14231117531420-Running-custom-Docker-applications-on-the-SecureEdge-Pro).

## Steps to Deploy Mosquitto MQTT Broker

### 1. Build and Push the Docker Image

To build the Mosquitto image from the Dockerfile, ensure you have the correct builder:

For Unix-based systems:

```bash
./setup-buildx-env.sh
```

For Windows:

```cmd
setup-buildx-env.cmd
```

Run the build and push script:

For Unix-based systems:

```bash
./build_and_push_containers.sh
```

For Windows:

```cmd
build_and_push_containers.cmd
```

### 2. Set Up the MQTT Broker Container on SecureEdge Pro

- Access the local web interface of the SecureEdge Pro.
- Create a `mqtt-broker` container using the `mqtt-broker` image with the following port mappings:

  ```
  Port Mapping: 1883:1883 (MQTT)
  Port Mapping: 9001:9001 (WebSocket, optional)
  ```

- If enabling persistence, create a volume:

  ```
  Volume: mosquitto-data -> /mosquitto/data
  ```

Refer to the screenshot for configuration details:  
![Create Container](secure_edge_pro_settings/create_container.png)

### 3. Start the Container

- Wait for the container to be created.
- Start the container.

Refer to the screenshot for details:  
![Running Container](secure_edge_pro_settings/running_container.png)

## Configuration

The broker uses a simple configuration file (`mosquitto.conf`) that you can modify to suit your needs.

### Default Configuration (mosquitto.conf)

```ini
# Allow anonymous connections (set to false to disable)
allow_anonymous true

# Listener for MQTT (default port 1883)
listener 1883

# Enable WebSocket listener on port 9001 (optional, for MQTT over WebSockets)
listener 9001
protocol websockets

# Logging
log_type all
log_dest stdout
```

### Customization Options

- **Persistence**: Enable persistent storage for MQTT messages.
- **Authentication**: Use a username/password file for access control.
- **TLS/SSL**: Secure the broker with SSL encryption (see the mosquitto.conf for options).

## Testing the Broker

### Subscribe to a Topic

To subscribe to an MQTT topic using mosquitto_sub:

```bash
mosquitto_sub -h <SecureEdge IP> -p 1883 -t 'test/topic'
```

Replace `<SecureEdge IP>` with the IP address of your device.

### Publish to a Topic

To publish a message to the MQTT broker:

```bash
mosquitto_pub -h <SecureEdge IP> -p 1883 -t 'test/topic' -m 'Hello from MQTT!'
```

## Optional: Enable Persistence

To enable message persistence across restarts, update the `mosquitto.conf` with the following lines:

```ini
persistence true
persistence_location /mosquitto/data/
```

When running the container, map a local directory for the persistent data:

```bash
docker run -d --name mqtt-broker -p 1883:1883 -p 9001:9001 -v /path/to/mosquitto/data:/mosquitto/data mqtt-broker
```

## Security (Optional)

You can secure the broker by enabling username/password authentication or TLS encryption. Here's a simple example of enabling basic authentication:

1. Create a password file:

```bash
mosquitto_passwd -c /path/to/passwordfile myuser
```

2. Update the configuration:

```ini
allow_anonymous false
password_file /mosquitto/config/passwordfile
```

For SSL/TLS encryption, add your certificates and update the `mosquitto.conf` file accordingly.

## Conclusion

Your Mosquitto MQTT broker is now running on the SecureEdge Pro and ready to handle MQTT messages. You can further customize the configuration to fit your security or performance needs.

For more advanced features, refer to the [Mosquitto Documentation](https://mosquitto.org/documentation/).
