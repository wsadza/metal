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
<!--- CONTENT --->

<table>
    <tr>
        <td><strong>Component</strong></td>
        <td><strong>Snippet</strong></td>
    </tr>
   <!--- element[0] --->
    <tr>
         <td><sup><a href="">Minimal Debian</a></sup></td>
         <td>
         <br>
         <sup><pre><code>
            docker run -d \
               -p 8080:8080 \
               -p 3478:3478/udp \
               -p 3478:3478/tcp \
               -p 9091:9091 \
               -e STREAMER_HOST=$(hostname -I | awk '{print $1}') \
               ghcr.io/utilizable/metal/minimal-debian:latest && \
               echo -e "\n\tApplication: http://$(hostname -I | awk '{print $1}'):8080" && \
               echo -e "\tSupervisor: http://$(hostname -I | awk '{print $1}'):9091\n"
         </code></pre></sup>
         </td>
    </tr>
    <!--- element[0] --->
    <!--- element[1] --->
    <tr>
       <td><sup><a href="">Minimal Ubuntu</a></sup></td>
       <td>
       <br><sup><pre><code>
         docker run -d \
            -p 8080:8080 \
            -p 3478:3478/udp \
            -p 3478:3478/tcp \
            -p 9091:9091 \
            -e STREAMER_HOST=$(hostname -I | awk '{print $1}') \
            ghcr.io/utilizable/metal/minimal-debian:latest && \
            echo -e "\n\tApplication: http://$(hostname -I | awk '{print $1}'):8080" && \
            echo -e "\tSupervisor: http://$(hostname -I | awk '{print $1}'):9091\n"
       </code></pre></sup>
       </td>
    </tr>
    <!--- element[1] ---> 
    <!--- element[2] --->
    <tr>
       <td><sup><a href="">Full Ubuntu</a></sup></td>
       <td>
       <br><sup><pre><code>
         docker run -d \
            -p 8080:8080 \
            -p 3478:3478/udp \
            -p 3478:3478/tcp \
            -p 9091:9091 \
            -e STREAMER_HOST=$(hostname -I | awk '{print $1}') \
            ghcr.io/utilizable/metal/full-ubuntu:latest && \
            echo -e "\n\tApplication: http://$(hostname -I | awk '{print $1}'):8080" && \
            echo -e "\tSupervisor: http://$(hostname -I | awk '{print $1}'):9091\n"
       </code></pre></sup>
       </td>
    </tr>
    <!--- element[2] --->
    <!--- element[3] --->
    <tr>
       <td><sup><a href="">Full Power</a>🤘</sup></td>
       <td>
       <br><sup><pre><code>
         docker run -d \
            --hostname stream \
            -p 8080:8080 \
            -p 3478:3478/udp \
            -p 3478:3478/tcp \
            -p 9091:9091 \
            -e STREAMER_HOST=$(hostname -I | awk '{print $1}') \
            -e SELKIES_ENCODER=nvh264enc \
            --gpus '"device=0"' \
            --tmpfs /dev/shm:rw \
            --shm-size 64m \
            --ipc host \
            --ulimit nofile=1024:524288 \
            --cap-add NET_ADMIN \
            --cap-add SYS_ADMIN \
            --cap-add SYS_NICE \
            --cap-add IPC_LOCK \
            --security-opt seccomp=unconfined \
            --security-opt apparmor=unconfined \
            ghcr.io/utilizable/metal/full-ubuntu:latest && \
            echo -e "\n\tApplication: http://$(hostname -I | awk '{print $1}'):8080" && \
            echo -e "\tSupervisor: http://$(hostname -I | awk '{print $1}'):9091\n"
       </code></pre></sup>
       </td>
    </tr>
    <!--- element[3] --->
</table>

##
<!---
#####################################################
# Usage - Docker-Compose
#####################################################
--->
### Usage - Docker-Compose
<sup>[(Back to Usage)](../../README.md#usage)</sup>
<br>
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

### Usage - Helm:
<sup>[(Back to Usage)](../../README.md#usage)</sup>

<img src="../../.media/asset/helper/asset_helper_wip.png" align="right" width="10%" height="auto"/>

<table>
    <tr>
        <td><strong>Component</strong></td>
        <td><strong>Description</strong></td>
    </tr>
    <tr>
        <td><sup><a href="">CHART-NAME</a></sup></td>
        <td><sup>DESCRIPTION</sup></td>
    </tr>
</table>

##

<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
