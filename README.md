# Metal

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun and glory - obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) and some [`docker-steam-headless`](https://github.com/Steam-Headless/docker-steam-headless) trickery.

Now it's a streaming powerhouse. Why? Just because!

### TLDR;
```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

## Preview
<img src=".media/preview.gif" align="center"/>

## Usage

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 

##

### Docker-Compose;

> [!IMPORTANT]  
> Please read the compose-file header before proceeding with the setup.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Compose - Nvidia</a></td>
        <td>How to Use nvidia runtime in docker container.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Compose - Companion</a></td>
        <td>How to re-use build-in coturn server from second stream instance.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Compose - Steam</a></td>
        <td>How to break isolation for flatpak (steam) apps.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Compose - Coturn</a></td>
        <td>How to spin-up external coturn server and configure stream to use it.</td>
    </tr>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Compose - Build</a></td>
        <td>How to build, all build arguments are listed.</td>
    </tr>
</table>

##

### K8S Manifest;

> [!CAUTION]
> Deployment below contains non-secure configuration (breaking container isolation) to fulfill steam-client needs.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Manifest - Deployment</a></td>
        <td>Fully configured deployment which uses Nvidia Runtime, breaking isolation, uses host networking,</td>
    </tr>
</table>


## Setup

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 
Ready to use workflows:

### Base:

- [`Nvidia Container Toolkit`](.github/workflows/building_docker.yml)

### Nvidia:

- [`Nvidia Container Toolkit`](.github/workflows/building_docker.yml)

### K3S:

- [`Nvidia GPU Device Plugin`](.github/workflows/tagging_semver.yml)

<br>

## Disclaimers

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 
