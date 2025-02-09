if [ -n "$(docker ps -q)" ]; then
  docker kill $(docker ps -q)
fi

docker build -t luke/metal-mono-v4 -f metal/monolithic/application/Dockerfile.v4 metal/monolithic/application

CMD="docker run -d \
  -p 8080:8080 \
  -p 2223:22 \
  -p 3478:3478/udp \
  -p 3478:3478/tcp \
  -p 9091:9091 \
  -e DISPLAY_SIZE_X=3456 \
  -e DISPLAY_SIZE_Y=2234 \
  -e STREAMER_HOST=$(hostname | tr '-' '.' | awk '{print $1}') \
  -e SELKIES_ENCODER=x264enc \
  --runtime=nvidia \
  --gpus all \
  -v ./workspace:/home/ubuntu/workspace \
  luke/metal-mono-v4"

echo $CMD
eval $CMD
