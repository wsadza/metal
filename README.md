<div align="center">
   <img src=".media/asset/badge/asset_badge_project.jpg" width="100%" height="auto"/>
   <br>
   
   <img src="https://labl.es/svg?text=Containerized%20Gaming&width=200&bgcolor=a93226" align="center" style="margin: 5px"/>
   <img src="https://labl.es/svg?text=Real-Time%20Streaming%20Platform&width=200&bgcolor=1e8449" align="center" style="margin: 5px"/>
   <img src="https://labl.es/svg?text=Play%20Anywhere&width=200&bgcolor=154360" align="center" style="margin: 5px"/>
   
   <div align="center" style="display: flex; gap: 5px; justify-content: center;">
      <img src="https://labl.es/svg?text=GPU%20Sharing&width=200&bgcolor=a50068" align="center"/>
      <img src="https://labl.es/svg?text=VDI&width=200&bgcolor=d35400" align="center"/>
   </div>
   
<img src=".media/asset/helper/asset_helper_wip.png" align="right" width="10%" height="auto"/>
<br>
</div>

<!---
$$\      $$\ $$$$$$$$\ $$$$$$$$\  $$$$$$\  $$\       
$$$\    $$$ |$$  _____|\__$$  __|$$  __$$\ $$ |      
$$$$\  $$$$ |$$ |         $$ |   $$ /  $$ |$$ |      
$$\$$\$$ $$ |$$$$$\       $$ |   $$$$$$$$ |$$ |      
$$ \$$$  $$ |$$  __|      $$ |   $$  __$$ |$$ |      
$$ |\$  /$$ |$$ |         $$ |   $$ |  $$ |$$ |      
$$ | \_/ $$ |$$$$$$$$\    $$ |   $$ |  $$ |$$$$$$$$\ 
\__|     \__|\________|   \__|   \__|  \__|\________
--->
# Metal
<img src=".media/asset/section/asset_section_a.png" align="left" width="5%" height="auto"/>

Ever been fascinated by remote gaming? Same! Inspired by the [`selkies-gstreamer`](https://github.com/selkies-project/selkies-gstreamer) project (a relic of [`Google Stadia's`](https://github.com/GoogleCloudPlatform/selkies-examples/tree/master) epicness), I decided to repack their [`egl solution`](https://github.com/selkies-project/docker-nvidia-egl-desktop) for fun - obviously. 

Introducing totally modular, Dockerized streaming service. Build it your way, whether you're on Debian or Ubuntu (I went agnostic on dependencies to keep it flexible). I revamped the structure for ultimate control, throwing in [`Supervisor`](http://supervisord.org/) magic, with a dash of [`s6-overlay`](https://github.com/just-containers/s6-overlay) structure.

Now it's a streaming powerhouse. Why? Just because!

##
<!---
#####################################################
# TL;DR
#####################################################
--->
### TL;DR 
> [!NOTE]  
> Minimal Debian image that utilizes software rendering ([llvmpipe](https://docs.mesa3d.org/drivers/llvmpipe.html])), suitable for WSL / Native linux instances.

```sh
docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -p 9091:9091 -e STREAMER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && sleep 10 && echo -e "\n\tApplication: http://$(hostname -I | awk '{print $1}'):8080" && echo -e "\tSupervisor: http://$(hostname -I | awk '{print $1}'):9091\n"
```

<!---
$$$$$$$\  $$$$$$$\  $$$$$$$$\ $$\    $$\ $$$$$$\ $$$$$$$$\ $$\      $$\ 
$$  __$$\ $$  __$$\ $$  _____|$$ |   $$ |\_$$  _|$$  _____|$$ | $\  $$ |
$$ |  $$ |$$ |  $$ |$$ |      $$ |   $$ |  $$ |  $$ |      $$ |$$$\ $$ |
$$$$$$$  |$$$$$$$  |$$$$$\    \$$\  $$  |  $$ |  $$$$$\    $$ $$ $$\$$ |
$$  ____/ $$  __$$< $$  __|    \$$\$$  /   $$ |  $$  __|   $$$$  _$$$$ |
$$ |      $$ |  $$ |$$ |        \$$$  /    $$ |  $$ |      $$$  / \$$$ |
$$ |      $$ |  $$ |$$$$$$$$\    \$  /   $$$$$$\ $$$$$$$$\ $$  /   \$$ |
\__|      \__|  \__|\________|    \_/    \______|\________|\__/     \__|
--->
## Preview
<div align="center">
<sup><code>It was easy, right?</code></sup>
<br>
<img src=".media/native/preview/gif/native_preview_gif_tldr.gif" width="800" height="auto"/>
</div>

<!---
$$$$$$$$\  $$$$$$\   $$$$$$\  
\__$$  __|$$  __$$\ $$  __$$\ 
   $$ |   $$ /  $$ |$$ /  \__|
   $$ |   $$ |  $$ |$$ |      
   $$ |   $$ |  $$ |$$ |      
   $$ |   $$ |  $$ |$$ |  $$\ 
   $$ |    $$$$$$  |\$$$$$$  |
   \__|    \______/  \______/
--->
## Table Of Contents:
- [Usage](#usage)
- [Setup](#setup)
- [Configuration](#configuration)
- [Development](#development)
- [Disclaimers](#disclaimers)

<!---
$$$$$$$\  $$$$$$$\  $$$$$$$$\ $$\    $$\ $$$$$$\ $$$$$$$$\ $$\      $$\ 
$$  __$$\ $$  __$$\ $$  _____|$$ |   $$ |\_$$  _|$$  _____|$$ | $\  $$ |
$$ |  $$ |$$ |  $$ |$$ |      $$ |   $$ |  $$ |  $$ |      $$ |$$$\ $$ |
$$$$$$$  |$$$$$$$  |$$$$$\    \$$\  $$  |  $$ |  $$$$$\    $$ $$ $$\$$ |
$$  ____/ $$  __$$< $$  __|    \$$\$$  /   $$ |  $$  __|   $$$$  _$$$$ |
$$ |      $$ |  $$ |$$ |        \$$$  /    $$ |  $$ |      $$$  / \$$$ |
$$ |      $$ |  $$ |$$$$$$$$\    \$  /   $$$$$$\ $$$$$$$$\ $$  /   \$$ |
\__|      \__|  \__|\________|    \_/    \______|\________|\__/     \__|
--->

<h2>Preview</h2>
<div align="center">
<sup><code>Steam? No Problem!</code></sup>
<br>
<img src=".media/native/preview/gif/native_preview_gif_steam.gif" width="800" height="auto"/>
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
<sup>[(Back to Top)](#table-of-contents)</sup><br>

<img src=".media/asset/section/asset_section_b.png" align="left" width="5%" height="auto"/>

This section provides guidance on deploying and configuring streaming instances using Docker, Docker Compose, and Kubernetes (K8S) manifests. It includes specific instructions for different Linux distributions and GPU acceleration.

### Table Of Contents:
  - [Usage `Docker`](./.docs/usage/USAGE.md#usage---docker) 
  - [Usage `Docker-Compose`](./.docs/usage/USAGE.md#usage---docker-compose)
  - [Usage `Kubernetes`](./.docs/usage/USAGE.md#usage---kubernetes)
  - [Setup `Helm`](./.docs/usage/USAGE.md#setup---helm) ⚠️
    
<!---
$$$$$$$\  $$$$$$$\  $$$$$$$$\ $$\    $$\ $$$$$$\ $$$$$$$$\ $$\      $$\ 
$$  __$$\ $$  __$$\ $$  _____|$$ |   $$ |\_$$  _|$$  _____|$$ | $\  $$ |
$$ |  $$ |$$ |  $$ |$$ |      $$ |   $$ |  $$ |  $$ |      $$ |$$$\ $$ |
$$$$$$$  |$$$$$$$  |$$$$$\    \$$\  $$  |  $$ |  $$$$$\    $$ $$ $$\$$ |
$$  ____/ $$  __$$< $$  __|    \$$\$$  /   $$ |  $$  __|   $$$$  _$$$$ |
$$ |      $$ |  $$ |$$ |        \$$$  /    $$ |  $$ |      $$$  / \$$$ |
$$ |      $$ |  $$ |$$$$$$$$\    \$  /   $$$$$$\ $$$$$$$$\ $$  /   \$$ |
\__|      \__|  \__|\________|    \_/    \______|\________|\__/     \__|
--->

<h2>Preview</h2>
<div align="center">
<sup><code>Want to play with others?</code></sup>
<br>
<img src=".media/native/preview/gif/native_preview_gif_companion.gif" align="center" width="800" height="auto"/>
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
<sup>[(Back to Top)](#table-of-contents)</sup><br>

<img src=".media/asset/section/asset_section_c.png" align="left" width="5%" height="auto"/>

This repository features an [Ansible Playbook](./setup/ansible) that guides you through a minimal setup, starting from the latest NVIDIA driver all the way to a fully functional Kubernetes cluster with GPU-MPS sharing capabilities. The [Ansible playbook](./setup/ansible/playbooks/playbook.yml) is self explanatory - tailored for Ubuntu and Debian distributions.

### Table Of Contents:
  - [Setup `Ansible`](./.docs/setup/SETUP.md#setup---ansible)
  - [Setup `Bash`](./.docs/setup/SETUP.md#setup---bash) ⚠️
  - [Setup `WSL`](./.docs/setup/SETUP.md#setup---wsl)
  - [Helpful Resources](./.docs/miscellaneous/HELPFUL_RESOURCES.md#setup---helpful---resources)

<!---
$$$$$$$\  $$$$$$$\  $$$$$$$$\ $$\    $$\ $$$$$$\ $$$$$$$$\ $$\      $$\ 
$$  __$$\ $$  __$$\ $$  _____|$$ |   $$ |\_$$  _|$$  _____|$$ | $\  $$ |
$$ |  $$ |$$ |  $$ |$$ |      $$ |   $$ |  $$ |  $$ |      $$ |$$$\ $$ |
$$$$$$$  |$$$$$$$  |$$$$$\    \$$\  $$  |  $$ |  $$$$$\    $$ $$ $$\$$ |
$$  ____/ $$  __$$< $$  __|    \$$\$$  /   $$ |  $$  __|   $$$$  _$$$$ |
$$ |      $$ |  $$ |$$ |        \$$$  /    $$ |  $$ |      $$$  / \$$$ |
$$ |      $$ |  $$ |$$$$$$$$\    \$  /   $$$$$$\ $$$$$$$$\ $$  /   \$$ |
\__|      \__|  \__|\________|    \_/    \______|\________|\__/     \__|
--->
<h2>Preview</h2>
<div align="center">
<sup><code>Play anywhere!</code></sup>
<br>
<img src=".media/native/preview/gif/native_preview_gif_mobile.gif" align="center" width="800" height="auto"/>   
<br>
</div>

<!---
 $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ 
$$  __$$\ $$  __$$\ $$$\  $$ |$$  _____|\_$$  _|$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |
$$ /  \__|$$ /  $$ |$$$$\ $$ |$$ |        $$ |  $$ /  \__|$$ |  $$ |$$ |  $$ |$$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |
$$ |      $$ |  $$ |$$ $$\$$ |$$$$$\      $$ |  $$ |$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |
$$ |      $$ |  $$ |$$ \$$$$ |$$  __|     $$ |  $$ |\_$$ |$$ |  $$ |$$  __$$< $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ |
$$ |  $$\ $$ |  $$ |$$ |\$$$ |$$ |        $$ |  $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |
\$$$$$$  | $$$$$$  |$$ | \$$ |$$ |      $$$$$$\ \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |
 \______/  \______/ \__|  \__|\__|      \______| \______/  \______/ \__|  \__|\__|  \__|  \__|   \______| \______/ \__|  \__|
--->

## Configuration
<sup>[(Back to Top)](#table-of-contents)</sup><br>

<img src=".media/asset/section/asset_section_d.png" align="left" width="5%" height="auto"/>

This section highlights the critical configurations and components necessary for maximizing the performance and functionality of your media streaming and communication setup. Each configuration is tailored to improve the overall user experience. You can find all the configurations described below in the [Dockerfile](https://github.com/utilizable/metal/blob/develop/build/docker/Dockerfile.debbased#L1314).

### Table Of Contents:
  - [Configuration `Selkies Gstreamer`](./.docs/configuration/CONFIGURATION.md#configuration---selkies-gstreamer)
  - [Configuration `Pipewire`](./.docs/configuration/CONFIGURATION.md#configuration---pipewire)
  - [Configuration `Coturn`](./.docs/configuration/CONFIGURATION.md#configuration---coturn)
  - [Configuration `Miscellaneous`](./.docs/configuration/CONFIGURATION.md#configuration---miscellaneous)
  - [Configuration `Graphic`](./.docs/configuration/CONFIGURATION.md#configuration---graphic)
  - [Configuration `Desktop`](./.docs/configuration/CONFIGURATION.md#configuration---desktop)
    
<!---
$$$$$$$\  $$$$$$$$\ $$\    $$\ $$$$$$$$\ $$\       $$$$$$\  $$$$$$$\  $$\      $$\ $$$$$$$$\ $$\   $$\ $$$$$$$$\ 
$$  __$$\ $$  _____|$$ |   $$ |$$  _____|$$ |     $$  __$$\ $$  __$$\ $$$\    $$$ |$$  _____|$$$\  $$ |\__$$  __|
$$ |  $$ |$$ |      $$ |   $$ |$$ |      $$ |     $$ /  $$ |$$ |  $$ |$$$$\  $$$$ |$$ |      $$$$\ $$ |   $$ |   
$$ |  $$ |$$$$$\    \$$\  $$  |$$$$$\    $$ |     $$ |  $$ |$$$$$$$  |$$\$$\$$ $$ |$$$$$\    $$ $$\$$ |   $$ |   
$$ |  $$ |$$  __|    \$$\$$  / $$  __|   $$ |     $$ |  $$ |$$  ____/ $$ \$$$  $$ |$$  __|   $$ \$$$$ |   $$ |   
$$ |  $$ |$$ |        \$$$  /  $$ |      $$ |     $$ |  $$ |$$ |      $$ |\$  /$$ |$$ |      $$ |\$$$ |   $$ |   
$$$$$$$  |$$$$$$$$\    \$  /   $$$$$$$$\ $$$$$$$$\ $$$$$$  |$$ |      $$ | \_/ $$ |$$$$$$$$\ $$ | \$$ |   $$ |   
\_______/ \________|    \_/    \________|\________|\______/ \__|      \__|     \__|\________|\__|  \__|   \__|
 --->
## Development
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/asset/section/asset_section_e.png" align="left" width="5%" height="auto"/>

I created this section primarily for myself to organize my future work, helping me quickly recall where I left off and where I can start.
Here, I will provide a full description of the Dockerfile, the repository structure, and my future plans.

### Table Of Contents:
  - Development - Structure
     - [Development - Structure - Monolith](#development---structure---monolith)
     - [Development - Structure - Microservices](#development---structure---microservices) ⚠️
     - [Development - Structure - Repository](#development---structure---repository)
  - [Development - Workflow](#development---workflow)
     - [Development - Workflow - CI](#development---workflow---ci)
     - [Development - Workflow - CD](#development---workflow---cd) ⚠️
  - [Development - Futher-Works](./docs/development/FUTHER_WORKS.md)

##
<!---
#####################################################
# Development - Structure
#####################################################
--->  
### Development - Structure 

<!---
#####################################################
# Development - Structure - Monolith
#####################################################
--->  
#### Development - Structure - Monolith 
<sup>[(Back to Development)](#development)</sup>
<br>
<sup>[(Back to Top)](#table-of-contents)</sup>
<br>

The Dockerfile encompasses all the essential components required for a seamless gaming experience, with management and orchestration handled by Supervisor.

<details>
   <summary>Core components: 📍</summary>
   <br>  
   <table>
      <tr align="center">
          <td><strong>Orchiestrator</strong></td>
          <td><strong>Component</strong></td>
          <td><strong>Description</strong></td>
          <td><strong>Purpose</strong></td>
      </tr>
      <tr>
         <td rowspan="7"><sup>Supervisord</sup></td>
      </tr>
      <tr>
          <td><sup>Kde-Plasma</sup></td>
          <td><sup>Desktop Environment</sup></td>
          <td><sup>Provides a graphical interface for user interaction</sup></td>
      </tr> 
      <tr>
          <td><sup>D-Bus</sup></td>
          <td><sup>Message bus system</sup></td>
          <td><sup>Facilitates communication between processes</sup></td>
      </tr> 
      <tr>
          <td><sup>PipeWire</sup></td>
          <td><sup>Multimedia server</sup></td>
          <td><sup>Handles audio and video streams</sup></td>
      </tr> 
      <tr>
          <td><sup>Selkies-Gstreamer</sup></td>
          <td><sup>Media processing framework</sup></td>
          <td><sup>Rremote desktop streaming platform</sup></td>
      </tr>   
      <tr>
          <td><sup>xvfb</sup></td>
          <td><sup>X virtual framebuffer</sup></td>
          <td><sup>Provides a display server for graphical applications</sup></td>
      </tr>
      <tr>
          <td><sup>Coturn</sup></td>
          <td><sup>TURN and STUN server</sup></td>
          <td><sup>Provides NAT traversal for WebRTC</sup></td>
      </tr>
   </table>
</details>
      
The complete image also includes additional features, such as a fully configured Steam client, Heroic Launcher, and VirtualGL.

<details>
   <summary>Additonal components: 📍</summary>
   <br>  
   <table>
       <tr>
           <td><strong>Component</strong></td>
           <td><strong>Description</strong></td>
           <td><strong>Purpose</strong></td>
       </tr>
       <tr>
           <td><sup>VirtualGL</sup></td>
           <td><sup>Open-source software</sup></td>
           <td><sup>Enables OpenGL applications to run on a remote server</sup></td>
       </tr>
       <tr>
           <td><sup>Wine</sup></td>
           <td><sup>Compatibility layer</sup></td>
           <td><sup>Allows Windows applications to run on Linux</sup></td>
       </tr>
       <tr>
           <td><sup>Lutris</sup></td>
           <td><sup>Gaming platform</sup></td>
           <td><sup>Manages and launches games from various sources</sup></td>
       </tr>
       <tr>
           <td><sup>Steam</sup></td>
           <td><sup>Digital distribution platform</sup></td>
           <td><sup>Offers games and software for purchase and download</sup></td>
       </tr>
       <tr>
           <td><sup>Heroic Launcher</sup></td>
           <td><sup>Game launcher</sup></td>
           <td><sup>Manages and launches games from the Epic Games Store</sup></td>
       </tr>
       <tr>
           <td><sup>WirePlumber</sup></td>
           <td><sup>Session manager</sup></td>
           <td><sup>Manages PipeWire sessions and connections</sup></td>
       </tr>
       <tr>
           <td><sup>Firefox-Nightly</sup></td>
           <td><sup>Web browser</sup></td>
           <td><sup>Provides a testing version of the Firefox browser with the latest features</sup></td>
       </tr>
   </table>
</details>

##

<div align="center">
<sup><code>What is this, Granny? Some outdated sysadmin techniques?</code></sup>
<br>   
<img src=".media/development/structure/monolith/development_structure_monolith_preview.png" width="600" height="auto"/>  
</div>

##

Each additional component has its own arguments to include during the build process, also you can choose the appropriate version of each component.

> [!NOTE]
> Each `RUN` block in the Dockerfile is independent — it doesn't rely on any other RUN blocks, allowing you to rearrange them as needed.

##

<div align="center">
<sup><code>Build Arguments? Who's using those? Come on, bro!</code></sup>
<br>      
<img src=".media/development/structure/monolith/development_structure_monolith_modularity.png" width="800" height="auto"/>  
</div>

##
<!---
#####################################################
# Development - Structure - Microservices
#####################################################
--->  
####  Development - Structure - Microservices
<sup>[(Back to Development)](#development)</sup>
<br>
<sup>[(Back to Top)](#table-of-contents)</sup>
<br>

<img src=".media/asset/helper/asset_helper_wip.png" align="right" width="10%" height="auto"/>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sit amet neque non dui luctus posuere. Phasellus laoreet elit eu diam ultrices fermentum. Ut posuere, quam sed blandit ornare, lacus nisi consectetur tortor, vel dictum erat enim a leo. Curabitur dictum tristique hendrerit.

##

<div align="center">
<sup><code>Finaly! Something intresting.</code></sup>
<br>   
<img src=".media/development/structure/microservices/development_structure_microservices_preview.png" width="800" height="auto"/>  
</div>

##
<!---
#####################################################
# Development - Structure - Repository
#####################################################
--->  
#### Development - Structure - Repository
<sup>[(Back to Development)](#development)</sup>
<br>
<sup>[(Back to Top)](#table-of-contents)</sup>
<br>


##
<!---
#####################################################
# Development - Workflow CICD
#####################################################
--->  
### Development - Workflow CICD
<!---
#####################################################
# Development - Workflow CICD
#####################################################
--->  
#### Development - Workflow CI
<sup>[(Back to Development)](#development)</sup>
<br>
<sup>[(Back to Top)](#table-of-contents)</sup>
<br>

##

#### Development - Workflow CD
<sup>[(Back to Development)](#development)</sup>
<br>
<sup>[(Back to Top)](#table-of-contents)</sup>
<br>


<!---
$$$$$$$\  $$$$$$\  $$$$$$\   $$$$$$\  $$\        $$$$$$\  $$$$$$\ $$\      $$\ $$$$$$$$\ $$$$$$$\   $$$$$$\  
$$  __$$\ \_$$  _|$$  __$$\ $$  __$$\ $$ |      $$  __$$\ \_$$  _|$$$\    $$$ |$$  _____|$$  __$$\ $$  __$$\ 
$$ |  $$ |  $$ |  $$ /  \__|$$ /  \__|$$ |      $$ /  $$ |  $$ |  $$$$\  $$$$ |$$ |      $$ |  $$ |$$ /  \__|
$$ |  $$ |  $$ |  \$$$$$$\  $$ |      $$ |      $$$$$$$$ |  $$ |  $$\$$\$$ $$ |$$$$$\    $$$$$$$  |\$$$$$$\  
$$ |  $$ |  $$ |   \____$$\ $$ |      $$ |      $$  __$$ |  $$ |  $$ \$$$  $$ |$$  __|   $$  __$$<  \____$$\ 
$$ |  $$ |  $$ |  $$\   $$ |$$ |  $$\ $$ |      $$ |  $$ |  $$ |  $$ |\$  /$$ |$$ |      $$ |  $$ |$$\   $$ |
$$$$$$$  |$$$$$$\ \$$$$$$  |\$$$$$$  |$$$$$$$$\ $$ |  $$ |$$$$$$\ $$ | \_/ $$ |$$$$$$$$\ $$ |  $$ |\$$$$$$  |
\_______/ \______| \______/  \______/ \________|\__|  \__|\______|\__|     \__|\________|\__|  \__| \______/
--->

## Disclaimers
<sup>[(Back to top)](#table-of-contents)</sup>

<img src=".media/asset/section/asset_section_f.png" align="left" width="5%" height="auto"/>

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
  <summary>Selkies-Gstreamer</summary>
  <br>
    This project has been developed and is supported in part by the National Research Platform (NRP) and the Cognitive Hardware and Software Ecosystem Community Infrastructure (CHASE-CI) at the University of California, San Diego, by funding from the National Science Foundation (NSF), with awards #1730158, #1540112, #1541349, #1826967, #2138811, #2112167, #2100237, and #2120019, as well as additional funding from community partners, infrastructure utilization from the Open Science Grid Consortium, supported by the National Science Foundation (NSF) awards #1836650 and #2030508, and infrastructure utilization from the Chameleon testbed, supported by the National Science Foundation (NSF) awards #1419152, #1743354, and #2027170. This project has also been funded by the Seok-San Yonsei Medical Scientist Training Program (MSTP) Song Yong-Sang Scholarship, College of Medicine, Yonsei University, the MD-PhD/Medical Scientist Training Program (MSTP) through the Korea Health Industry Development Institute (KHIDI), funded by the Ministry of Health & Welfare, Republic of Korea, and the Student Research Bursary of Song-dang Institute for Cancer Research, College of Medicine, Yonsei University.
  </details> 
  
</ul>

##

<div align="center">
   <img src=".media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
