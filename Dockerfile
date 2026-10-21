FROM ubuntu:latest

# Install curl, unzip, and tzdata
RUN apt-get update && apt-get install -y curl unzip tzdata && rm -rf /var/lib/apt/lists/*

# Download the official Xray release binary directly (bypassing installer scripts)
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && mkdir -p /usr/local/share/xray /usr/local/etc/xray \
    && unzip /tmp/xray.zip -d /usr/local/share/xray/ \
    && rm /tmp/xray.zip

# Create a symbolic link for easy execution
RUN ln -s /usr/local/share/xray/xray /usr/local/bin/xray

# Create a default SOCKS config file directly inside the image
RUN echo '{"inbounds":[{"port":1080,"protocol":"socks","settings":{"auth":"noauth"}}],"outbounds":[{"protocol":"freedom"}]}' > /usr/local/etc/xray/config.json

# Expose port 1080
EXPOSE 1080

# Run Xray core
CMD ["xray", "run", "-config", "/usr/local/etc/xray/config.json"]
