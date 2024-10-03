# Metal

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun and glory - obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) and some [`docker-steam-headless`](https://github.com/Steam-Headless/docker-steam-headless) trickery.

Now it's a streaming powerhouse. Why? Just because!

### TLDR; 
```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

## 🔸 Preview
<img src=".media/preview.gif" align="center"/>

## 🔹 Usage

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 

##
### Docker;

> [!TIP]
> The DOCKER_HOST variable should point to IP of the machine where stream-instance is launching.

- Minimal-Debian:
  <br>
  ```sh
  docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"
  ```
  
- Minimal-Ubuntu:
  <br>
  ```sh
  docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"
  ```
  
- Full-Ubuntu:
  <br>
  ```sh
  docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/full-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"
  ```
  
### Docker - Compose;

> [!IMPORTANT]  
> Please read the compose-file header before proceeding with the setup.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Nvidia</a></td>
        <td>Guide on using the Nvidia runtime within Docker containers.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Companion</a></td>
        <td>Instructions on reusing the built-in Coturn server for a second stream instance.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Steam</a></td>
        <td>Steps to disable isolation for Flatpak Steam applications.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Coturn</a></td>
        <td>Setup for an external Coturn server and configuring stream to use it.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Build</a></td>
        <td>Instructions for building with a list of all available build arguments.</td>
    </tr>
</table>

##

### K8S - Manifest;

> [!CAUTION]
> Deployment below contains non-secure configuration (breaking container isolation) to fulfill steam-client needs.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Deployment</a></td>
        <td>A fully configured deployment utilizing the Nvidia runtime, with broken isolation, host networking, and an internal (built-in) TURN server.</td>
    </tr>
</table>

##

### K8S - Helm;

> [!WARNING]  
> 🚧 Under Construction. 🚧

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Chart</a></td>
        <td>Update in progress; no content available yet!</td>
    </tr>
</table>

## 🔸 Setup

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 
Ready to use workflows:

### Base:

- [`Nvidia Container Toolkit`](.github/workflows/building_docker.yml)

### Nvidia:

- [`Nvidia Container Toolkit`](.github/workflows/building_docker.yml)

### K3S:

- [`Nvidia GPU Device Plugin`](.github/workflows/tagging_semver.yml)

<br>

## 🔹 Disclaimers

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 
