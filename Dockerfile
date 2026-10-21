FROM alpine:latest
RUN apk update && apk add --no-cache curl bash tzdata
RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
EXPOSE 1080
CMD ["xray", "run", "-config", "/etc/xray/config.json"]
