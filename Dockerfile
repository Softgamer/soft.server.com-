FROM ubuntu:latest

# Update package lists and install curl and bash
RUN apt-get update && apt-get install -y curl bash tzdata

# Install Xray core cleanly
RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# Expose port 1080
EXPOSE 1080

# Run Xray core
CMD ["xray", "run", "-config", "/usr/local/etc/xray/config.json"]
