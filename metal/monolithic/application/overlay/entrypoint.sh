#!/bin/bash

# Execute all container init scripts
for init_script in /etc/cont-init.d/*/*.sh; do
    echo "${init_script}"
    sudo chmod +x "${init_script}"
    sudo -E "${init_script:?}"
done

# Prepare all run-* scripts 
for init_script in /usr/bin/start_*.sh; do
    echo $init_script
    sudo chmod +x ${init_script}
done

# Consume global config
source /etc/bash.bashrc

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf --nodaemon  

