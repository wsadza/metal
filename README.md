Metal
============

Ever been fascinated by remote gaming? Same! Inspired by the [Selkies-GSTreamer]("https://github.com/selkies-project/selkies-gstreamer") project (a relic of Google Stadia's epicness), I decided to repack their [EGL solution]("https://github.com/selkies-project/docker-nvidia-egl-desktop") - for fun, obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [s6-overlay]("https://github.com/just-containers/s6-overlay") and some [Docker-Steam-Headless]("https://github.com/Steam-Headless/docker-steam-headless") trickery.

Now it's a streaming powerhouse. Why? Just because!

### TLDR;

```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

## Preview


## Configuration




#Metal Repository README.strucutre

header: Logo
body-a: TLDR
footer: Link to FUNDING.md

metal:
    sectrion:
        - name: logo

        - name: TLDR 
        
        - name: Description 

        - questions:

          - questions: Why we don't need to install nvidia-drivers?
            answer: nvidia-docker-toolkit attach host EGL libraries (32/64bit) into container 

          - questions: Why we don't need to install nvidia-drivers?
            answer: nvidia-docker-toolkit attach host EGL libraries (32/64bit) into container 



#sudo dpkg --add-architecture i386
#sudo apt update
#sudo apt install libc6:i386
#sudo apt install -y pkg-config libglvnd-dev
#sudo apt install libc6:i386
#sudo ./nvidia-installer --install-compat32-libs
