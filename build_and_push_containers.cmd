REM Ensure the correct builder is in use
docker buildx use secure-edge-pro

REM Build the node-red image
docker buildx build --platform linux/arm64/v8 --tag 192.168.140.1:5000/eclipse-mosquitto:2.0 --push .
