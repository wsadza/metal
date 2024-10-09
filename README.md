> [!NOTE]  
> - Low-Latency streaming service.
> - Game everywhere.
> - Docker is new gaming platform.

# Metal
<img src=".media/sections/section-a.png" align="left" width="5%" height="auto"/>

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun and learning - obviously.

Introducing my totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in Supervisord magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) and some [`docker-steam-headless`](https://github.com/Steam-Headless/docker-steam-headless) trickery.

Now it's a streaming powerhouse. Why? Just because!

##

### TLDR: 
> [!NOTE]  
> Minimal Ubuntu image that utilizes software rendering ([llvmpipe](https://docs.mesa3d.org/drivers/llvmpipe.html])), suitable for WSL / Native linux instances.

```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n" 
```

##

### Table Of Contents:
- [Usage](#usage)
  - [Usage `Docker`](#usage---docker)
  - [Usage `Docker-Compose`](#usage---docker-compose)
  - [Usage `Kubernetes`](#usage---kubernetes---manifest)
  - [Usage `Helm`](#usage---kubernetes---helm)
- [Setup](#setup)
  - [Setup by `Ansible` Playbook](#setup---ansible)
  - [Setup by `Bash` Script](#setup---bash)
- [Configuration](#configuration)
  - [Configuration `Selkies Gstreamer`](#configuration---streamer)
  - [Configuration `Pipewire`](#configuration---pipewire)
  - [Configuration `Coturn`](#configuration---coturn)
  - [Configuration `Miscellaneous`](#configuration---coturn)
- [Contributing](#contributing)
  - [Structure Dockerfile](#contributing---dockerfile)
  - [Structure Repository](#contributing---repository)
  - [CICD Workflow](#contributing---cicd---workflow)
  - [Futher Works](#contributing---futher---works)
- [Disclaimers](#disclaimers)

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
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/sections/section-b.png" align="left" width="5%" height="auto"/>

This section provides guidance on deploying and configuring streaming instances using Docker, Docker Compose, and Kubernetes (K8S) manifests. It includes specific instructions for different Linux distributions and GPU acceleration.

##

### Usage - Docker:
<sup>[(Back to top)](#table-of-contents)</sup>

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
  
- <details>
    <summary>Full-Power: 📍</summary>
    <br>
    <ul>
      <sup style="display: block; margin-top: 5px;">
        <li><a href="https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html">[Ensure that nvidia-ctr is installed]</a></li>
      </sup>
      <br>
      <sup style="display: block; margin-top: 5px;">
        <li><a href="">[Flatpak (steam) requires breaking container isolation]</a></li>
      </sup>
    </ul>
  </details>  
  
  ```sh
  docker run -d --hostname stream -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -e DOCKER_HOST=$(hostname -I | awk '{print $1}') -e SELKIES_ENCODER=nvh264enc --gpus '"device=0"' --tmpfs /dev/shm:rw --shm-size 64m --ipc host --ulimit nofile=1024:524288 --cap-add NET_ADMIN --cap-add SYS_ADMIN --cap-add SYS_NICE --cap-add IPC_LOCK --security-opt seccomp=unconfined --security-opt apparmor=unconfined ghcr.io/utilizable/metal/full-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"
  ```
##

### Usage - Docker-Compose:
<sup>[(Back to top)](#table-of-contents)</sup>

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

### Usage - Kubernetes - Manifest:
<sup>[(Back to top)](#table-of-contents)</sup>

> [!CAUTION]
> The deployment below contains configurations that break container isolation to meet the requirements of the Steam client.

<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Deployment</a></td>
        <td>A fully configured deployment utilizing the Nvidia runtime, with broken isolation, host networking, and an internal (built-in) TURN server.</td>
    </tr>
</table>

##

### Usage - Kubernetes - Helm:
<sup>[(Back to top)](#table-of-contents)</sup>
<img src=".media/work_in_progress.png" align="right" width="10%" height="auto"/>


<table>
    <tr>
        <td><a href=".github/workflows/building_docker.yml">Chart</a></td>
        <td>Update in progress; no content available yet!</td>
    </tr>
</table>


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

## Setup
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/sections/section-c.png" align="left" width="5%" height="auto"/>

This repository features an [Ansible Playbook](./setup/ansible) that guides you through a minimal setup, starting from the latest NVIDIA driver all the way to a fully functional Kubernetes cluster with GPU-MPS sharing capabilities. The [Ansible playbook](./setup/ansible/playbooks/playbook.yml) is self explanatory - tailored for Ubuntu and Debian distributions, as well as NVIDIA hardware. 

> [!TIP]
> <details>
>  <summary>Helpful Resources </summary>
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
> GPU-Sharing functionality (MPS) isn't working under WSL-Linux. ([#3024](https://github.com/canonical/microk8s/issues/3024))

##

### Setup - Ansible
<sup>[(Back to top)](#table-of-contents)</sup>

Clone this repository and run the [setup.sh](./setup/ansible/setup.sh) bash script. This will fetch all the necessary Ansible dependencies and execute the playbook.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/ansible && ./setup.sh
```

##

### Setup - Bash
<sup>[(Back to top)](#table-of-contents)</sup>
<img src=".media/work_in_progress.png" align="right" width="10%" height="auto"/>

Clone this repository and run the [setup.sh](./setup/setup/bash/setup.sh) bash script. This will fetch and install all the necessary dependencies and components.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/bash && ./setup.sh
```

## Configuration
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/sections/section-d.png" align="left" width="5%" height="auto"/>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 


##

## Disclaimers
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/sections/section-d.png" align="left" width="5%" height="auto"/>

This section contains important disclaimers regarding the ownership of software and the funding sources for the project. Please review the details carefully to understand the rights associated with the software and the contributions of supporting organizations.

<br>

<ul>
  
  <details>
  <summary>Copyright</summary>
  <br>
    I hereby declare that I do not claim any rights to the software used in this repository. 
    All software, including any components, libraries, and dependencies, belongs to their original creators.
    All copyright and other intellectual property rights associated with this software remain with their respective owners. 
    This statement is intended to clarify that I do not assert any rights to the intellectual property or any part of this software.
    It is recommended to review the licensing terms of each used component before using or modifying them.
  </details> 
  
  <details>
  <summary>Selkies Gstreamer</summary>
  <br>
    This project has been developed and is supported in part by the National Research Platform (NRP) and the Cognitive Hardware and Software Ecosystem Community Infrastructure (CHASE-CI) at the University of California, San Diego, by funding from the National Science Foundation (NSF), with awards #1730158, #1540112, #1541349, #1826967, #2138811, #2112167, #2100237, and #2120019, as well as additional funding from community partners, infrastructure utilization from the Open Science Grid Consortium, supported by the National Science Foundation (NSF) awards #1836650 and #2030508, and infrastructure utilization from the Chameleon testbed, supported by the National Science Foundation (NSF) awards #1419152, #1743354, and #2027170. This project has also been funded by the Seok-San Yonsei Medical Scientist Training Program (MSTP) Song Yong-Sang Scholarship, College of Medicine, Yonsei University, the MD-PhD/Medical Scientist Training Program (MSTP) through the Korea Health Industry Development Institute (KHIDI), funded by the Ministry of Health & Welfare, Republic of Korea, and the Student Research Bursary of Song-dang Institute for Cancer Research, College of Medicine, Yonsei University.
  </details> 
  
</ul>

## Further Works / To-do
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/sections/section-d.png" align="left" width="5%" height="auto"/>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porttitor leo id eros venenatis, in ornare lacus rhoncus. Proin non tincidunt dolor. Integer mattis laoreet facilisis. Vivamus pharetra, risus eu elementum ultricies, erat tortor pulvinar ante, eu scelerisque turpis ligula sit amet orci. Pellentesque a ante nunc. Mauris ornare nisi ut ornare laoreet. Nunc convallis eu arcu eget sollicitudin. 
