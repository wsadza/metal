#!/bin/bash

# Make sure that everything under ${HOME} belongs to user 
sudo -E chmod -R a+rwX ${HOME}
sudo -E chown -R ${USER_UID}:${USER_UID} ${HOME}

# Change Permissions for config opt 
sudo chmod -R a+rwX /opt
sudo chown -R ${USER_UID}:${USER_UID} /opt

# Execute all container core init scripts
for init_script in /etc/cont-init.d/core/*.sh; do
    echo "${init_script}"
    sudo chmod +x "${init_script}"
    sudo -E "${init_script:?}"
done

# Execute all container optional init scripts
for init_script in /etc/cont-init.d/optional/*.sh; do
    echo "${init_script}"
    sudo chmod +x "${init_script}"
    sudo -E "${init_script:?}"
done

# Prepare all run-* scripts 
for init_script in /usr/bin/*_start_*.sh; do
    echo $init_script
    sudo chmod +x ${init_script}
done

# Consume global config
source /etc/bash.bashrc

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf --nodaemon  
