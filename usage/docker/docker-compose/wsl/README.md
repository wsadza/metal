> [!CAUTION]
> - The instructions below are designed to leverage the NVIDIA GPU.
> - Hardware rendering may encounter significant issues.

> [!NOTE]  
> - WSL setup can be useful for software-rendering usage.

# WSL
Throughout my exploration of WSL, I've gathered key insights about graphics rendering. It turns out that relying on EGL rendering isn't the best option. However, using the software renderer (llvmpipe) can still provide you some gaming experience - atleast terraria works 😉

##

#### Key problems:
- It seems that WSL struggles with utilizing the EGL/GLX NVIDIA libraries, relying instead on the libraries provided by WSL at `/usr/lib/wsl/lib`.
- Each time I attempted to install or use the libnvidia-egl package along with the -iglx extension of Xvfb, it resulted in an error.
  
##
  
#### Poor Performance of glxgears64
<img src=".media/glxspheres64.png" align="center"/>

#### Helpful Resources:

 - [OpenGL Configuration Guide on Arch Wiki](https://wiki.archlinux.org/title/OpenGL)
 - [Installing Mesa on Ubuntu](https://itsfoss.com/install-mesa-ubuntu/)
 - [WSLg GPU Selection Documentation](https://github.com/microsoft/wslg/wiki/GPU-selection-in-WSLg)
 - [Sample WSL Configuration File](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#example-wslconfig-file)
 - [WSLg GPU Docker Examples](https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md)
 - [Nvidia/Nvidia-Cuda Installation Guide](https://gist.github.com/wangruohui/df039f0dc434d6486f5d4d098aa52d07)


## 🔸 Setting Up - Windows

Install Chocolatey (Windows Package Manager):

  -
    ```sh
    https://chocolatey.org/install#generic
    ```

Install latest Nvidia drivers:

  - 
    ```sh
    choco install nvidia-display-driver
    ```
Install Windows Subsystem for Linux:

  - 
    ```sh
    choco install wsl2
    ```
    
> [!WARNING]
> - Depending on your setup, you may need to enable the `Windows Subsystem for Linux` feature in Windows.
> - Open PowerShell and run the following command:
> 
>   ```sh
>   optionalfeatures
>   ```

##

### WSL configuration (Optional)

To create or open the .wslconfig file, use the following Powershell command:

```
notepad $env:userprofile\.wslconfig
```

This file allows you to configure settings that apply to all Linux distributions running on WSL 2. <br>The .wslconfig file is located in your Windows home directory.

```
[wsl2]

# Limits the virtual machine's memory usage to 8 GB; defaults to 50% of total RAM.
memory=8GB

# Specifies the virtual machine to utilize 6 virtual processors, corresponding to the number of CPU cores.
processors=6

# Allocates 32 GB of swap space; the default is typically 25% of the available RAM.
swap=32GB
```

##

### WSL Snippets

Most common WSL commands:

  - 
    ```sh
    wsl --install Ubuntu-24.04 --web-download # Fetching Ubuntu 24.04 <br><br>
    ```
  - 
    ```sh
    wsl -d ubuntu-24.04 -u root # Executing Ubuntu 24.04 as root
    ```
  - 
    ```sh
    wsl --unregister Ubutnu-24.04 # Uninstalling Ubuntu 24.04
    ```
  - 
    ```sh
    wsl --shutdown Ubutnu-24.04 # Turning-off Ubuntu 24.04
    ```
    
## 🔹 Setting Up - WSL Linux

### Installation Script

This bash script automates the installation of Docker, Docker Compose, and the NVIDIA container toolkit.

```
# Install docker / docker-compose / nvidia-container-toolkit
#!/bin/bash
# Add i386 architecture support
sudo dpkg --add-architecture i386;
# Add NVIDIA container toolkit GPG key and repository
sudo apt-get update;
sudo apt-get install gnupg gnupg2;
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
# Update package lists
sudo apt-get update
# Install required packages
sudo apt-get install -y \
  docker.io \
  docker-compose \
  nvidia-container-toolkit
# Configure NVIDIA container toolkit for Docker
sudo nvidia-ctk runtime configure --runtime=docker
# Restart Docker service to apply changes
sudo systemctl restart docker
```

##

### Environment Variables

To optimize the GPU utilization and configure necessary services within your WSL environment, the following environment variables should be set:

<table>
    <thead>
        <tr>
            <th>Environment Variable</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>  
    <tr>
        <td><code>LIBVA_DRIVER_NAME</code></td>
        <td><code>d3d12</code></td>
        <td>Specifies the VA driver to use.</td>
    </tr>
    <tr>
        <td><code>MESA_D3D12_DEFAULT_ADAPTER_NAME</code></td>
        <td><code>NVIDIA</code></td>
        <td>Sets the default D3D12 adapter name.</td>
    </tr>
    <tr>
        <td><code>VK_ICD_FILENAMES</code></td>
        <td><code>/usr/share/vulkan/icd.d/dzn_icd.x86_64.json</code></td>
        <td>Path to the Vulkan ICD file.</td>
    </tr>
    <tr>
        <td><code>LD_LIBRARY_PATH</code></td>
        <td><code>/usr/lib/wsl/lib</code></td>
        <td>Specifies the library search path.</td>
    </tr>
</table>

