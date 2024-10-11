<div align="center">
   <img src="../../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>

##
<!--- WIP --->
<img src="../../../.media/asset/helper/asset_helper_wip.png" align="right" width="8%" height="auto"/>

<!---
#####################################################
# Development - Structure - Monolithic
#####################################################
--->  
#### Development - Structure - Monolithic
<sup>[(Back to Development)](../../../README.md#table-of-contents-4)</sup>
<br>

The Dockerfile encompasses all the essential components required for a seamless gaming experience, with management and orchestration handled by Supervisor.

<br>
<div align="left">
   <table>
      <tr align="center">
          <td><strong></strong></td>
          <td><strong>Component</strong></td>
          <td><strong>Description</strong></td>
          <td><strong>Purpose</strong></td>
      </tr>
      <tr>
         <td rowspan="9"><sup>Core<br>Component</sup></td>
      <tr>
      <tr align="left">
          <td><sup>Supervisord</sup></td>
          <td><sup>Process control system for managing and monitoring services.</sup></td>
          <td><sup>To ensure that the core components and applications are running smoothly and automatically restart them if they fail.</sup></td>
      </tr>
      <tr align="left">
          <td><sup>Kde-Plasma</sup></td>
          <td><sup>Desktop Environment</sup></td>
          <td><sup>Provides a graphical interface for user interaction</sup></td>
      </tr> 
      <tr align="left">
          <td><sup>D-Bus</sup></td>
          <td><sup>Message bus system</sup></td>
          <td><sup>Facilitates communication between processes</sup></td>
      </tr> 
      <tr align="left">
          <td><sup>PipeWire</sup></td>
          <td><sup>Multimedia server</sup></td>
          <td><sup>Handles audio and video streams</sup></td>
      </tr> 
      <tr align="left">
          <td><sup>Selkies-Gstreamer</sup></td>
          <td><sup>Media processing framework</sup></td>
          <td><sup>Rremote desktop streaming platform</sup></td>
      </tr>   
      <tr align="left">
          <td><sup>xvfb</sup></td>
          <td><sup>X virtual framebuffer</sup></td>
          <td><sup>Provides a display server for graphical applications</sup></td>
      </tr>
      <tr align="left">
          <td><sup>Coturn</sup></td>
          <td><sup>TURN and STUN server</sup></td>
          <td><sup>Provides NAT traversal for WebRTC</sup></td>
      </tr>
      <tr>
         <td rowspan="9"><sup>Optional<br>Component</sup></td>
      <tr>
       <tr align="left">
           <td><sup>VirtualGL</sup></td>
           <td><sup>Open-source software</sup></td>
           <td><sup>Enables OpenGL applications to run on a remote server</sup></td>
       </tr>
       <tr align="left">
           <td><sup>Wine</sup></td>
           <td><sup>Compatibility layer</sup></td>
           <td><sup>Allows Windows applications to run on Linux</sup></td>
       </tr>
       <tr align="left">
           <td><sup>Lutris</sup></td>
           <td><sup>Gaming platform</sup></td>
           <td><sup>Manages and launches games from various sources</sup></td>
       </tr>
       <tr align="left">
           <td><sup>Steam</sup></td>
           <td><sup>Digital distribution platform</sup></td>
           <td><sup>Offers games and software for purchase and download</sup></td>
       </tr>
       <tr align="left">
           <td><sup>Heroic Launcher</sup></td>
           <td><sup>Game launcher</sup></td>
           <td><sup>Manages and launches games from the Epic Games Store</sup></td>
       </tr>
       <tr align="left">
           <td><sup>WirePlumber</sup></td>
           <td><sup>Session manager</sup></td>
           <td><sup>Manages PipeWire sessions and connections</sup></td>
       </tr>
       <tr align="left">
           <td><sup>Firefox-Nightly</sup></td>
           <td><sup>Web browser</sup></td>
           <td><sup>Provides a testing version of the Firefox browser with the latest features</sup></td>
       </tr>
   </table>
</div>

##

<div align="center">
<sup><code>What is this, Granny? Some outdated sysadmin techniques?</code></sup>
<br>   
<img src="../../../.media/development/structure/monolithic/development_structure_monolithic_preview.png" width="600" height="auto"/>  
</div>

##

Each additional component has its own arguments to include during the build process, also you can choose the appropriate version of each component.

> [!NOTE]
> Each `RUN` block in the Dockerfile is independent — it doesn't rely on any other RUN blocks, allowing you to rearrange them as needed.

##

<div align="center">
<sup><code>Build Arguments? Who's using those? Come on, bro!</code></sup>
<br>      
<img src="../../../.media/development/structure/monolithic/development_structure_monolithic_modularity.png" width="800" height="auto"/>  
</div>

##

<div align="center">
   <img src="../../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
