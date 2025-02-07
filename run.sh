if [ -n "$(docker ps -q)" ]; then
  docker kill $(docker ps -q)
fi

CMD="docker run -d \
  -p 8080:8080 \
  -p 2223:22 \
  -p 3478:3478/udp \
  -p 3478:3478/tcp \
  -p 9091:9091 \
  -e DISPLAY_SIZE_X=3456 \
  -e DISPLAY_SIZE_Y=2234 \
  -e STREAMER_HOST=$(hostname | tr '-' '.' | awk '{print $1}') \
  -e SELKIES_ENCODER=nvh264enc \
  ghcr.io/wsadza/metal/full-ubuntu:latest"

echo $CMD
eval $CMD
