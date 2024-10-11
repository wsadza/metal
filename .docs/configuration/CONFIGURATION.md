<div align="left">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>

##
<!---
#####################################################
# Configuration - COTURN
#####################################################
--->  
### Configuration - Coturn
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>TURN_PORT</sup></td>
           <td><sup>Port for the TURN server.</sup></td>
           <td><sup>3478</sup></td>
       </tr>
       <tr>
           <td><sup>TURN_USERNAME</sup></td>
           <td><sup>Username for TURN authentication.</sup></td>
           <td><sup>user</sup></td>
       </tr>
       <tr>
           <td><sup>TURN_PASSWORD</sup></td>
           <td><sup>Password for TURN authentication.</sup></td>
           <td><sup>password</sup></td>
       </tr>
       <tr>
           <td><sup>TURN_MIN_PORT</sup></td>
           <td><sup>Minimum port range for media connections.</sup></td>
           <td><sup>49160</sup></td>
       </tr>
       <tr>
           <td><sup>TURN_MAX_PORT</sup></td>
           <td><sup>Maximum port range for media connections.</sup></td>
           <td><sup>49200</sup></td>
       </tr>
       <tr>
           <td><sup>TURN_REALM</sup></td>
           <td><sup>Realm for TURN server authentication.</sup></td>
           <td><sup>local.host</sup></td>
       </tr>
   </table>
</div>

##
<!---
#####################################################
# Configuration - Pipewire
#####################################################
--->  
### Configuration - Pipewire
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>DISABLE_RTKIT</sup></td>
           <td><sup>Disable RTKit support.</sup></td>
           <td><sup>y</sup></td>
       </tr>
       <tr>
           <td><sup>PIPEWIRE_PORT</sup></td>
           <td><sup>Port for PipeWire.</sup></td>
           <td><sup>4713</sup></td>
       </tr>
       <tr>
           <td><sup>PIPEWIRE_DEBUG</sup></td>
           <td><sup>Debug level for PipeWire.</sup></td>
           <td><sup>E</sup></td>
       </tr>
       <tr>
           <td><sup>WIREPLUMBER_DEBUG</sup></td>
           <td><sup>Debug level for WirePlumber.</sup></td>
           <td><sup>E</sup></td>
       </tr>
       <tr>
           <td><sup>PIPEWIRE_LATENCY</sup></td>
           <td><sup>Latency settings for PipeWire.</sup></td>
           <td><sup>32/48000</sup></td>
       </tr>
   </table>
</div>

##
<!---
#####################################################
# Configuration - Selkies-Gstreamer 
#####################################################
--->  
### Configuration - Selkies-Gstreamer 
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>SELKIES_AUDIO_BITRATE</sup></td>
           <td><sup>Audio bitrate for streaming.</sup></td>
           <td><sup>128000</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_FRAMERATE</sup></td>
           <td><sup>Frame rate for video streaming.</sup></td>
           <td><sup>60</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_VIDEO_BITRATE</sup></td>
           <td><sup>Video bitrate for streaming.</sup></td>
           <td><sup>2000</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_ENABLE_BASIC_AUTH</sup></td>
           <td><sup>Enable basic authentication.</sup></td>
           <td><sup>false</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_ENABLE_RESIZE</sup></td>
           <td><sup>Allow resizing of the video stream.</sup></td>
           <td><sup>true</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_ENCODER</sup></td>
           <td><sup>Video encoder to be used.</sup></td>
           <td><sup>x264enc</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_INTERPOSER</sup></td>
           <td><sup>Path to the joystick interposer library.</sup></td>
           <td><sup>/usr/$LIB/selkies_joystick_interposer.so</sup></td>
       </tr>
       <tr>
           <td><sup>GST_DEBUG</sup></td>
           <td><sup>Debug level for GStreamer.</sup></td>
           <td><sup>${GST_DEBUG:-*:2}</sup></td>
       </tr>
       <tr>
           <td><sup>GSTREAMER_PATH</sup></td>
           <td><sup>Path to the GStreamer installation.</sup></td>
           <td><sup>/opt/gstreamer</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_ENABLE_METRICS_HTTP</sup></td>
           <td><sup>Enable HTTP metrics endpoint.</sup></td>
           <td><sup>true</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_METRICS_HTTP_PORT</sup></td>
           <td><sup>Port for the metrics HTTP endpoint.</sup></td>
           <td><sup>9090</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_ADDR</sup></td>
           <td><sup>Address to bind the service to.</sup></td>
           <td><sup>0.0.0.0</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_PORT</sup></td>
           <td><sup>Port for the main streaming service.</sup></td>
           <td><sup>8080</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_TURN_PORT</sup></td>
           <td><sup>Port for the TURN service.</sup></td>
           <td><sup>3478</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_TURN_USERNAME</sup></td>
           <td><sup>Username for the TURN service.</sup></td>
           <td><sup>user</sup></td>
       </tr>
       <tr>
           <td><sup>SELKIES_TURN_PASSWORD</sup></td>
           <td><sup>Password for the TURN service.</sup></td>
           <td><sup>password</sup></td>
       </tr>
   </table>
</div>

##
<!---
#####################################################
# Configuration - Miscellaneous
#####################################################
--->  
### Configuration - Miscellaneous
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>DBUS_SESSION_BUS_ADDRESS</sup></td>
           <td><sup>Address for the D-Bus session bus.</sup></td>
           <td><sup>unix:path=${XDG_RUNTIME_DIR}/dbus-session</sup></td>
       </tr>
       <tr>
           <td><sup>APPIMAGE_EXTRACT_AND_RUN</sup></td>
           <td><sup>Extract and run AppImage.</sup></td>
           <td><sup>1</sup></td>
       </tr>
       <tr>
           <td><sup>SUPERVISOR_PORT</sup></td>
           <td><sup>Port for Supervisor.</sup></td>
           <td><sup>9091</sup></td>
       </tr>
       <tr>
           <td><sup>PULSE_SERVER</sup></td>
           <td><sup>Address for the PulseAudio server.</sup></td>
           <td><sup>unix:${XDG_RUNTIME_DIR}/pulse-server</sup></td>
       </tr>
       <tr>
           <td><sup>PRIME_RENDERER_GLOBAL</sup></td>
           <td><sup>Use EGL device globaly.</sup></td>
           <td><sup>true</sup></td>
       </tr>
       <tr>
           <td><sup>PRIME_RENDERER_WINE</sup></td>
           <td><sup>Use EGL device only for WINE applications.</sup></td>
           <td><sup>true</sup></td>
       </tr>   
   </table>
</div>

##
<!---
#####################################################
# Configuration - Graphic
#####################################################
--->  
### Configuration - Graphic
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>NVIDIA_VISIBLE_DEVICES</sup></td>
           <td><sup>Specifies which NVIDIA devices are visible to the application.</sup></td>
           <td><sup>all</sup></td>
       </tr>
       <tr>
           <td><sup>NVIDIA_DRIVER_CAPABILITIES</sup></td>
           <td><sup>Specifies the capabilities of the NVIDIA driver to expose to the application.</sup></td>
           <td><sup>all</sup></td>
       </tr>
       <tr>
           <td><sup>LD_LIBRARY_PATH</sup></td>
           <td><sup>Path to NVIDIA libraries.</sup></td>
           <td><sup>${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/nvidia/lib:/usr/local/nvidia/lib64</sup></td>
       </tr>
       <tr>
           <td><sup>PATH</sup></td>
           <td><sup>Path to NVIDIA binaries.</sup></td>
           <td><sup>/usr/local/nvidia/bin${PATH:+:${PATH}}</sup></td>
       </tr>
       <tr>
           <td><sup>__NV_PRIME_RENDER_OFFLOAD</sup></td>
           <td><sup>Enables PRIME render offload.</sup></td>
           <td><sup>1</sup></td>
       </tr>
       <tr>
           <td><sup>__GL_SYNC_TO_VBLANK</sup></td>
           <td><sup>Syncs to vertical blanking interval.</sup></td>
           <td><sup>0</sup></td>
       </tr>
       <tr>
           <td><sup>__GLX_VENDOR_LIBRARY_NAME</sup></td>
           <td><sup>Specifies the GLX vendor library to use.</sup></td>
           <td><sup>mesa</sup></td>
       </tr>
   </table>
</div>

##
<!---
#####################################################
# Configuration - Desktop
#####################################################
--->  
### Configuration - Desktop
<sup>[(Back to Configuration)](../../README.md#table-of-contents-3)</sup>
<br>

<div align="left">
   <table>
       <tr>
           <td><strong>VARIABLE</strong></td>
           <td><strong>DESCRIPTION</strong></td>
           <td><strong>DEFAULT</strong></td>
       </tr>
       <tr>
           <td><sup>DESKTOP_SESSION</sup></td>
           <td><sup>Specifies the desktop session type.</sup></td>
           <td><sup>plasma</sup></td>
       </tr>
       <tr>
           <td><sup>XDG_SESSION_DESKTOP</sup></td>
           <td><sup>Defines the desktop environment being used.</sup></td>
           <td><sup>KDE</sup></td>
       </tr>
       <tr>
           <td><sup>XDG_CURRENT_DESKTOP</sup></td>
           <td><sup>Indicates the current desktop environment.</sup></td>
           <td><sup>KDE</sup></td>
       </tr>
       <tr>
           <td><sup>XDG_SESSION_TYPE</sup></td>
           <td><sup>Specifies the type of session (e.g., X11 or Wayland).</sup></td>
           <td><sup>x11</sup></td>
       </tr>
       <tr>
           <td><sup>KDE_FULL_SESSION</sup></td>
           <td><sup>Indicates whether a full KDE session is running.</sup></td>
           <td><sup>true</sup></td>
       </tr>
       <tr>
           <td><sup>KDE_SESSION_VERSION</sup></td>
           <td><sup>Version number of the KDE session.</sup></td>
           <td><sup>5</sup></td>
       </tr>
       <tr>
           <td><sup>KDE_APPLICATIONS_AS_SCOPE</sup></td>
           <td><sup>Defines how KDE applications are scoped.</sup></td>
           <td><sup>1</sup></td>
       </tr>
       <tr>
           <td><sup>KWIN_COMPOSE</sup></td>
           <td><sup>Setting for KWin composition.</sup></td>
           <td><sup>N</sup></td>
       </tr>
       <tr>
           <td><sup>KWIN_EFFECTS_FORCE_ANIMATIONS</sup></td>
           <td><sup>Forces animations in KWin effects.</sup></td>
           <td><sup>0</sup></td>
       </tr>
       <tr>
           <td><sup>KWIN_EXPLICIT_SYNC</sup></td>
           <td><sup>Enables explicit synchronization in KWin.</sup></td>
           <td><sup>0</sup></td>
       </tr>
       <tr>
           <td><sup>KWIN_X11_NO_SYNC_TO_VBLANK</sup></td>
           <td><sup>Disables syncing to the vertical blanking interval in KWin.</sup></td>
           <td><sup>1</sup></td>
       </tr>
       <tr>
           <td><sup>GTK_IM_MODULE</sup></td>
           <td><sup>Input method module for GTK applications.</sup></td>
           <td><sup>fcitx</sup></td>
       </tr>
       <tr>
           <td><sup>QT_IM_MODULE</sup></td>
           <td><sup>Input method module for Qt applications.</sup></td>
           <td><sup>fcitx</sup></td>
       </tr>
       <tr>
           <td><sup>XIM</sup></td>
           <td><sup>Input method for X applications.</sup></td>
           <td><sup>fcitx</sup></td>
       </tr>
       <tr>
           <td><sup>XMODIFIERS</sup></td>
           <td><sup>Specifies the input method modifiers.</sup></td>
           <td><sup>"@im=fcitx"</sup></td>
       </tr>
   </table>
</div>

##

<div align="left">
   <img src="../../.media/asset/badge/asset_badge_project_backgroundless.png" width="15%" height="auto"/>
</div>
