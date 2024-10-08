# Use an official Eclipse Mosquitto image
FROM eclipse-mosquitto:2.0

# Copy the default configuration file
COPY mosquitto.conf /mosquitto/config/mosquitto.conf

# Expose the default MQTT port (1883) and WebSocket port (9001)
EXPOSE 1883
EXPOSE 9001

# Run the Mosquitto broker
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
