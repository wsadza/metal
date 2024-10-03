# Metal
<img src=".media/asset-a.png" align="right" style="width: 7%; height: auto;" />

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun and glory - obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) and some [`docker-steam-headless`](https://github.com/Steam-Headless/docker-steam-headless) trickery.

Now it's a streaming powerhouse. Why? Just because!

### TLDR;
```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

## Preview
<img src=".media/preview.gif" align="center" style="width: 7%; height: auto;" />

## Usage

## Setup

## Disclaimers

> [!IMPORTANT]  
> I am not the owner of the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) software, solution belongs to its orginal creators.
        
> [!NOTE]  
> None of the containers prepared in this repository contain pre-installed games.

## 

<div align="center">
<img src=".media/asset-g.png" align="center" style="width: 30%; height: auto;" />
</div>
