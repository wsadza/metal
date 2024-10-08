> [!NOTE]  
> - Low-Latency streaming service.
> - Game everywhere.
> - Docker is your-new gaming platform.

# Metal
<img src=".media/sections/section-a.png" align="left" width="5%" height="auto"/>

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun and learning - obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) and some [`docker-steam-headless`](https://github.com/Steam-Headless/docker-steam-headless) trickery.

Now it's a streaming powerhouse. Why? Just because!

> [!IMPORTANT]  
> - This project acts as a glue, integrating multiple solutions and patterns.
> - I'm just here to containerize it!
> - Obviously games are not included. 😉

##

### TLDR: 
> [!NOTE]  
> - Minimal Ubuntu image that utilizes software rendering ([llvmpipe](https://docs.mesa3d.org/drivers/llvmpipe.html])), suitable for WSL / Native linux instances.

```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

##

### TOC:[](#TOC)
- [Usage](#usage)
  - [Usage `docker`](#usage-docker)
  - [Usage `docker-compose`](#usage-docker-compose)
  - [Usage `kubernetes`](#usage-kubernetes-manifest)
  - [Usage `helm`](#usage-kubernetes-helm)
- [Setup](#setup-integration)

## Preview - Steam
<div align="center">
<kbd><img src=".media/preview-steam.gif" width="800" height="auto"/></kbd>
</div>

<!---
$$\   $$\  $$$$$$\   $$$$$$\   $$$$$$\  $$$$$$$$\ 
$$ |  $$ |$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|
$$ |  $$ |$$ /  \__|$$ /  $$ |$$ /  \__|$$ |      
$$ |  $$ |\$$$$$$\  $$$$$$$$ |$$ |$$$$\ $$$$$\    
$$ |  $$ | \____$$\ $$  __$$ |$$ |\_$$ |$$  __|   
$$ |  $$ |$$\   $$ |$$ |  $$ |$$ |  $$ |$$ |      
\$$$$$$  |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$$\ 
 \______/  \______/ \__|  \__| \______/ \________|
--->

## Usage
<img src=".media/sections/section-b.png" align="left" width="5%" height="auto"/>

This section provides guidance on deploying and configuring streaming instances using Docker, Docker Compose, and Kubernetes (K8S) manifests. It includes specific instructions for different Linux distributions and GPU acceleration.

{#usage-docker}
### Docker:

> [!TIP]
> The `${DOCKER_HOST}` variable should point to IP of the machine where stream-instance is launching.

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

##
> [!NOTE]  
> Below is a complete one-line configuration that will enable GPU usage and allow you to run Steam.

> [!CAUTION]
> - The snippet below requires the Nvidia Container Toolkit!
> - It includes configurations that break container isolation!

- Give me the power! 🤘
  <br>
  
  ```sh
  docker run -d --hostname stream -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') -e SELKIES_ENCODER=nvh264enc --gpus '"device=0"' --tmpfs /dev/shm:rw --shm-size 64m --ipc host --ulimit nofile=1024:524288 --cap-add NET_ADMIN --cap-add SYS_ADMIN --cap-add SYS_NICE --cap-add IPC_LOCK --security-opt seccomp=unconfined --security-opt apparmor=unconfined ghcr.io/utilizable/metal/full-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"
  ```
  
##

##usage-docker-compose
### Docker - Compose:

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

#usage-kubernetes-manifests
### Kubernetes - Manifest:

> [!CAUTION]
> The deployment below contains configurations that break container isolation to meet the requirements of the Steam client.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Deployment</a></td>
        <td>A fully configured deployment utilizing the Nvidia runtime, with broken isolation, host networking, and an internal (built-in) TURN server.</td>
    </tr>
</table>

##

#usage-kubernetes-helm
### Kubernetes - Helm:

> [!WARNING]  
> 🚧 Under Construction. 🚧

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Chart</a></td>
        <td>Update in progress; no content available yet!</td>
    </tr>
</table>

<br>
<div align="right">[ <a href="#TOC">↑ Back to top ↑</a> ]</div>

## Preview - Second Instance
<div align="center">
<kbd><img src=".media/preview.gif" align="center" width="800" height="auto"/></kbd>
</div>

<!---
 $$$$$$\  $$$$$$$$\ $$$$$$$$\ $$\   $$\ $$$$$$$\  
$$  __$$\ $$  _____|\__$$  __|$$ |  $$ |$$  __$$\ 
$$ /  \__|$$ |         $$ |   $$ |  $$ |$$ |  $$ |
\$$$$$$\  $$$$$\       $$ |   $$ |  $$ |$$$$$$$  |
 \____$$\ $$  __|      $$ |   $$ |  $$ |$$  ____/ 
$$\   $$ |$$ |         $$ |   $$ |  $$ |$$ |      
\$$$$$$  |$$$$$$$$\    $$ |   \$$$$$$  |$$ |      
 \______/ \________|   \__|    \______/ \__|      
--->

#setup
## Setup
<img src=".media/sections/section-c.png" align="left" width="5%" height="auto"/>

This repository features an [Ansible script](./setup/ansible) that guides you through a minimal setup, starting from the latest NVIDIA driver all the way to a fully functional Kubernetes cluster with GPU-MPS sharing capabilities. The Ansible playbook is tailored for Ubuntu and Debian distributions, as well as NVIDIA hardware. 

> [!Note]
> <details>
>  <summary>Key Components:</summary>
>    <br>
>    <ul>
>        <li>nvidia-driver</li>
>        <li>nvidia-device-plugin</li>
>        <li>docker</li>
>        <li>nvidia-container-toolkit</li>
>        <li>k3s</li>
>    </ul>
> </table>
> </details>

> [!TIP]
> <details>
>  <summary>Helpful Resources:</summary>
>    <br>
> <ul>
>    <li><a href="https://www.reddit.com/r/devops/comments/10xty21/comparison_among_techniques_to_share_gpus_in/">Techniques to share GPU in Kubernetes</a></li>
>    <li><a href="https://docs.google.com/document/d/1H-ddA11laPQf_1olwXRjEDbzNihxprjPr74pZ4Vdf2M/edit?pli=1">MPS Support in the Kubernetes GPU Device Plugin</a></li>
>    <li><a href="https://www.declarativesystems.com/2023/11/04/kubernetes-nvidia.html">Kubernetes + NVIDIA on K3S</a></li>
>    <li><a href="https://jayground8-github-io.translate.goog/blog/20240324-k8s-device-plugin?_x_tr_sl=auto&_x_tr_tl=pl&_x_tr_hl=pl&_x_tr_hist=true">Using NVIDIA GPU Multi-Process Service with k8s-device-plugin</a></li>
>    <li><a href="https://gist.github.com/bgulla/5ea0e7fd310b5db4f9b66036d1cdb3d3">GPU Operator Snippet</a></li>
>    <li><a href="https://github.com/NVIDIA/k8s-device-plugin/tree/main/deployments/helm/nvidia-device-plugin">Nvidia Device Plugin</a></li>
>    <li><a href="https://github.com/UntouchedWagons/K3S-NVidia">K3S-NVidia</a></li>
>    <li><a href="https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html">NVIDIA Container Toolkit</a></li>
> </ul>
> </table>
> </details>

> [!WARNING]  
> - Final GPU-Sharing (MPS) functionality isn't working on WSL. ([#3024](https://github.com/canonical/microk8s/issues/3024))

##

#setup-ansible
### Ansible

Clone this repository and run the [run ansible](./setup/ansible/run_ansible.sh) bash script. This will fetch all the necessary Ansible dependencies and execute the playbook.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/ansible && ./run_ansible.sh
```

##

#setup-bash
### Bash

> [!WARNING]  
> 🚧 Under Construction. 🚧

Clone this repository and run the [run ansible](./setup/ansible/run_ansible.sh) bash script. This will fetch all the necessary Ansible dependencies and execute the playbook.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/bash && ./entrypoint.sh
```

<br>
<div align="right">[ <a href="#TOC">↑ Back to top ↑</a> ]</div>

## Disclaimers
<img src=".media/sections/section-d.png" align="left" width="5%" height="auto"/>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 

<br>
<div align="right">[ <a href="#TOC">↑ Back to top ↑</a> ]</div>

## Further Works / To-do
<img src=".media/sections/section-d.png" align="left" width="5%" height="auto"/>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 

<br>
<div align="right">[ <a href="#TOC">↑ Back to top ↑</a> ]</div>
