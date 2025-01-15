# Use the official Eclipse Mosquitto image
FROM eclipse-mosquitto:2.0

# Create directory for certificates
RUN mkdir -p /mosquitto/config/certs

# Copy Mosquitto configuration file
COPY mosquitto.conf /mosquitto/config/mosquitto.conf

# Copy TLS certificates
COPY mosquitto_certs/ca.crt /mosquitto/config/certs/ca.crt
COPY mosquitto_certs/server.crt /mosquitto/config/certs/server.crt
COPY mosquitto_certs/server.key /mosquitto/config/certs/server.key

# Expose the default MQTT port (1883) and WebSocket port (9001)
EXPOSE 1883
EXPOSE 9001
# Expose MQTT over TLS port
EXPOSE 8883

# Set permissions for certificates
RUN chmod 644 /mosquitto/config/certs/ca.crt \
    && chmod 644 /mosquitto/config/certs/server.crt \
    && chmod 600 /mosquitto/config/certs/server.key

# Run Mosquitto broker
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
