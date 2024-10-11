<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>

##
<!---
#####################################################
# Setup - Ansible
#####################################################
--->
### Setup - Ansible
<sup>[(Back to Usage)](../../README.md#setup)</sup>
<br>
<!--- CONTENT --->

Clone this repository and run the [setup.sh](./setup/ansible/setup.sh) bash script. This will fetch all the necessary Ansible dependencies and execute the playbook.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/ansible && ./setup.sh
```

##
<!---
#####################################################
Setup - Bash - WIP!
#####################################################
--->
### Setup - Bash
<sup>[(Back to Usage)](../../README.md#setup)</sup>
<br>
<!--- CONTENT --->

<!--- WIP --->
<img src="../../.media/asset/helper/asset_helper_wip.png" align="right" width="10%" height="auto"/>
<!--- WIP --->

Clone this repository and run the [setup.sh](./setup/setup/bash/setup.sh) bash script. This will fetch and install all the necessary dependencies and components.

```sh
git clone https://github.com/utilizable/metal.git && cd metal/setup/bash && ./setup.sh
```

##
<!---
#####################################################
Setup - WSL
#####################################################
--->
### Setup - WSL
<sup>[(Back to Usage)](../../README.md#setup)</sup>
<br>
<!--- CONTENT --->

Consider this more of a curiosity than a genuine configuration; Vulkan doesn’t function properly on WSL-Linux, which severely limits gaming options.

> [!WARNING]  
> - GPU-Sharing functionality (MPS) isn't working under WSL-Linux. ([#3024](https://github.com/canonical/microk8s/issues/3024))
> - Vulkan isn't functioning properly; only selected linux-native games are working.
> - Performance is lacking; you can only play very lightweight games.

Instructions for setting up WSL with the D3D12 renderer are provided in a separate [documentation file](./WSL.md).

##

<div align="center">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
