## Setup
<img src="../.media/sections/section-c.png" align="left" width="5%" height="auto"/>

This repository features an Ansible script that guides you through a minimal setup, starting from the latest NVIDIA driver all the way to a fully functional Kubernetes cluster with GPU-MPS sharing capabilities. The Ansible playbook is tailored for Ubuntu and Debian distributions, as well as NVIDIA hardware. 

> [!NOTE]  
> You can execute setup playbook on WSL, but please note that the final MPS-sharing functionality isn't working there [#3024](https://github.com/canonical/microk8s/issues/3024).

##

#### Helpful Resources:

 - Kubernetes
   - [Techniques to share GPU in Kubernetes](https://www.reddit.com/r/devops/comments/10xty21/comparison_among_techniques_to_share_gpus_in/)
   - [MPS Support in the Kubernetes GPU Device Plugin](https://docs.google.com/document/d/1H-ddA11laPQf_1olwXRjEDbzNihxprjPr74pZ4Vdf2M/edit?pli=1)
   - [Kubernetes + NVIDIA on K3S](https://www.declarativesystems.com/2023/11/04/kubernetes-nvidia.html) 
   - [Using NVIDIA GPU Multi-Process Service with k8s-device-plugin](https://jayground8-github-io.translate.goog/blog/20240324-k8s-device-plugin?_x_tr_sl=auto&_x_tr_tl=pl&_x_tr_hl=pl&_x_tr_hist=true)
   - [GPU Operator Snippet](https://gist.github.com/bgulla/5ea0e7fd310b5db4f9b66036d1cdb3d3)
   - [Nvidia Device Plugin](https://github.com/NVIDIA/k8s-device-plugin/tree/main/deployments/helm/nvidia-device-plugin)
   - [https://github.com/UntouchedWagons/K3S-NVidia](https://github.com/UntouchedWagons/K3S-NVidia)
 - Docker
   - [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
 - K3S
    - [NVIDIA Container Runtime Support](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
      
##

#### Usage:

> [!CAUTION]
> - Ansible script is suitable for debbased distributions!

Clone this repository and run the run_ansible bash script. This will fetch all the necessary Ansible dependencies and execute the playbook.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/ansible && ./run_ansible.sh
```
