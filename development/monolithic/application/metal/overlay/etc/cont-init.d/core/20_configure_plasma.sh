#!/bin/bash

# -----------------------
# kscreenlockerrc

kwriteconfig5 \
  --file /etc/xdg/kscreenlockerrc \
  --group Daemon \
  --key Autolock false \
  --key LockOnResume false \
  --key LockOnSuspend false \
  --key LockOnLogout false \

kwriteconfig5 \
  --file /etc/xdg/kdeglobals \
  --group "KDE Action Restrictions" \
  --key action/lock_screen false \
  --key LockOnSuspend false \
  --key LockOnLogout false

# -----------------------
# kdeglobals

kwriteconfig5 \
  --file /etc/xdg/kdeglobals \
  --group "KDE Action Restrictions" \
  --key action/lock_screen false \
  --key logout false \
  --key LockOnSuspend false \
  --key LockOnLogout false

kwriteconfig5 \
  --file /etc/xdg/kdeglobals \
  --group "KDE" \
  --key SingleClick false

kwriteconfig5 \
  --file /etc/xdg/kdeglobals \
  --group "General" \
  --key BrowserApplication firefox.desktop

# -----------------------
# kwinrc

kwriteconfig5 \
  --file /etc/xdg/kwinrc \
  --group "Compositing" \
  --key Enabled false
