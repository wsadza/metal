#!/bin/bash

# Add google DNS server
echo -e "->Adding Google DNS Server" \
  && echo "nameserver 8.8.8.8" \
	| sudo tee /etc/resolv.conf > /dev/null

# Install Tools 
echo -e "->Installing Tools" \
  && apt-get -qq update \
  && apt-get -qq install -y \
       python3 \
       ansible \
       gettext-base \
       sshpass \
       jq

# Execute Ansible Playbook 
echo -e "->Executing Ansible" \
  && TARGET_HOST=localhost \
     LC_ALL=C.UTF-8 \
     ANSIBLE_CONFIG=./ansible.cfg \
     ANSIBLE_INVENTORY=./inventories/hosts \
     ansible-playbook ./playbooks/playbook.yml
