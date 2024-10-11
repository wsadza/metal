<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>

##
<!---
#####################################################
# Usage - Docker
#####################################################
--->
### Usage - Docker
<sup>[(Back to Usage)](../../README.md#usage)</sup>
<br>
<sup>[(Back to Readme)](../../README.md#table-of-contents)</sup><br>
<!--- CONTENT --->

<ul>
<!-- element [0] -->    
   <li>
      <p>Minimal-Debian:</p>
      <pre><code>docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -p 9091:9091 -e STREAMER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-debian:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"</code></pre>
   </li>
   <!-- #element [0] -->    
   <!-- element [1] -->    
   <li>
      <p>Minimal-Ubuntu:</p>
      <pre><code>docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -p 9091:9091 -e STREAMER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/minimal-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"</code></pre>
   </li>
<!-- #element [1] -->    
   
<!-- element [2] -->    
   <li>
      <p>Full-Ubuntu:</p>
      <pre><code>docker run -d -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -p 9091:9091 -e STREAMER_HOST=$(hostname -I | awk '{print $1}') ghcr.io/utilizable/metal/full-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"</code></pre>
   </li>
<!-- #element [2] -->    

<!-- element [3] -->    
   <li>
      <p>Full-Power: 🤘</p>
      <ul>
         <sup>
            <li><a href="https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html">[Ensure that nvidia-ctr is installed]</a></li>
         </sup>
      <br>
         <sup>
            <li><a href="">[Flatpak (steam) requires breaking container isolation]</a></li>
         </sup>
      </ul>
      <br>
      <pre><code>docker run -d --hostname stream -p 8080:8080 -p 3478:3478/udp -p 3478:3478/tcp -p 9091:9091 -e STREAMER_HOST=$(hostname -I | awk '{print $1}') -e SELKIES_ENCODER=nvh264enc --gpus '"device=0"' --tmpfs /dev/shm:rw --shm-size 64m --ipc host --ulimit nofile=1024:524288 --cap-add NET_ADMIN --cap-add SYS_ADMIN --cap-add SYS_NICE --cap-add IPC_LOCK --security-opt seccomp=unconfined --security-opt apparmor=unconfined ghcr.io/utilizable/metal/full-ubuntu:latest && echo -e "\n\thttp://$(hostname -I | awk '{print $1}'):8080\n"</code></pre>
   </li>
<!-- #element [3] -->          
</ul>

##
<!---
#####################################################
# Usage - Docker-Compose
#####################################################
--->
### Usage - Docker-Compose
<sup>[(Back to Usage)](../../README.md#usage)</sup>
<br>
<sup>[(Back to Readme)](../../README.md#table-of-contents)</sup><br>
<!--- CONTENT --->

<table>
    <tr>
        <td><strong>Component</strong></td>
        <td><strong>Description</strong></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.nvidia</a></sup></td>
        <td><sup>Guide on using the Nvidia runtime within Docker containers.</sup></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.companion</a></sup></td>
        <td><sup>Instructions on reusing the built-in Coturn server for a second stream instance.</sup></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.steam</a></sup></td>
        <td><sup>Steps to disable isolation for Flatpak Steam applications.</sup></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.coturn</a></sup></td>
        <td><sup>Setup for an external Coturn server and configuring stream to use it.</sup></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.build</a></sup></td>
        <td><sup>Instructions for building with a list of all available build arguments.</sup></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">docker-compose.wsl</a></sup></td>
        <td><sup>Instructions for utilizing NVIDIA GPU in WSL container.</sup></td>
    </tr>
</table>

##
<!---
#####################################################
# Usage - Kubernetes
#####################################################
--->
### Usage - Kubernetes
<sup>[(Back to Usage)](../../README.md#usage)</sup>
<br>
<sup>[(Back to Readme)](../../README.md#table-of-contents)</sup><br>
<!--- CONTENT --->

<table>
    <tr>
        <td><strong>Component</strong></td>
        <td><strong>Description</strong></td>
    </tr>
    <tr>
        <td><sup><a href=".github/workflows/building_docker.yml">deployment.yml</a></sup></td>
        <td><sup>A fully configured deployment utilizing the Nvidia runtime, with broken isolation, host networking, and an internal (built-in) TURN server.</sup></td>
    </tr>
</table>

##
<!---
#####################################################
# Usage - Helm - WIP!
#####################################################
--->
<!--- WIP 
### Usage - Helm:
<sup>[(Back to Usage)](../../README.md#usage)</sup>
<br>
<sup>[(Back to Readme)](../../README.md#table-of-contents)</sup><br>

<img src="../../.media/asset/helper/asset_helper_wip.png" align="right" width="10%" height="auto"/>
##
--->

<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
