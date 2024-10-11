<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>

<!---
#####################################################
# Helpful Resources
#####################################################
--->
## Helpful Resources
<sup>[(Back to README)](../../README.md#table-of-contents)</sup>
<br>
<!--- CONTENT --->

<!---
#####################################################
# Helpful Resources - Setup
#####################################################
--->
### Helpful Resources - Setup
<!--- CONTENT --->

#### Setup - General

> [!TIP]
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

##

#### Setup - WSL
<!--- CONTENT --->

> [!TIP]
> <ul>
>    <li><a href="https://github.com/microsoft/wslg/wiki/GPU-selection-in-WSLg">WSLg GPU Selection Documentation</a></li>
>    <li><a href="https://learn.microsoft.com/en-us/windows/wsl/wsl-config#example-wslconfig-file">Sample WSL Configuration File</a></li>
>    <li><a href="https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md">WSLg GPU Docker Examples</a></li>
> </ul>
> </table>

##

<!---
#####################################################
# Helpful Resources - Questions 
#####################################################
--->
### Helpful Resources - Questions
<sup>[(Back to README)](../../README.md#table-of-contents)</sup>
<br>
<!--- CONTENT --->

#### Question: Why don't we need to install the NVIDIA driver in the finall container?
<details>
<summary>Answer</summary>
<br>
<!--- ANSWER --->
   
The NVIDIA driver toolkit ships all the necessary libraries to the final container.

<!--- ANSWER --->
</details>

##

#### Question: Why don't we need to use VirtualGL?
<details>
<summary>Answer</summary>
<br>
<!--- ANSWER --->   
   
Think of containers like laptops. On laptops, we often deal with NVIDIA Prime and Bumblebee to manage GPU usage. However, in containers, the primary GPU is usually LLVMPipe, instead of the Intel integrated GPU. To ensure we use the NVIDIA GPU, we can set the following environment variables:
<br><br>
   
   - `__NV_PRIME_RENDER_OFFLOAD=1`
   - `__GLX_VENDOR_LIBRARY_NAME=NVIDIA`
   
   These settings force graphic applications to utilize the NVIDIA GPU. For more details, you can refer to the official NVIDIA documentation [here](https://download.nvidia.com/XFree86/Linux-x86_64/435.17/README/primerenderoffload.html).
   
<!--- ANSWER --->
</details>

##

#### Question: Why can't I fully utilize WSL?
<details>
<summary>Answer</summary>
<br>
<!--- ANSWER --->      
   
Unfortunately, Microsoft started implementing [D3D12](https://www.phoronix.com/news/Mesa-24.1-Zink-D3D12-Default) in Mesa around year or two ago? - which limits our ability to use all Vulkan functions, resulting in significantly poor performance.

<!--- ANSWER --->   
</details>

##

#### Question: Are there other solutions to share GPU?
<details>
<summary>Answer</summary>
<br>
<!--- ANSWER --->   
   
- **Intel**: Offers various solutions for virtual GPU sharing, particularly through their integrated graphics.
- **AMD**: Provides solutions like MxGPU, which allows multiple virtual machines to share a single GPU.
- **Dual-Coder Crack for RTX Series 20***: Enables the use of NVIDIA's vGPU technology on consumer-grade RTX 20 series cards.
- **Older NVIDIA GPUs**: Models like the K2 support vGPU technology, which can be leveraged for virtualization and resource sharing.

Some resources:
- [Intel vGPU KubeVirt](https://kubevirt.io/2021/intel-vgpu-kubevirt.html)
- [NVIDIA vGPU on Proxmox VE](https://pve.proxmox.com/wiki/NVIDIA_vGPU_on_Proxmox_VE)
- [DualCoder vGPU Unlock](https://github.com/DualCoder/vgpu_unlock)
- [Using vGPU Unlock with Proxmox 7](https://www.michaelstinkerings.org/using-vgpu-unlock-with-proxmox-7/)
- [vgpu-proxmox GitLab](https://gitlab.com/polloloco/vgpu-proxmox)
  
<!--- ANSWER --->  
</details>


##

#### Question: Are there plans to configure and discover solutions for Intel/AMD?
<details>
<summary>Answer</summary>
<br>
<!--- ANSWER --->   
   
It could happen in the future — who knows? But for now, NVIDIA is the dominant player in the market. Honestly, if you're looking to use your PC GPU unit for computing, you're pretty much compelled to go with NVIDIA

<!--- ANSWER ---> 
</details>

##

<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
