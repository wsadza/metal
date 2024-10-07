#!/bin/bash

echo -e "->Installing dependencies" \
  && apt-get -qq update \
  && apt-get -qq install -y \
       python3 \
       ansible \
       gettext-base \
       sshpass \
       jq

# -----------------------

echo -e "->Executing Ansible" \
  && TARGET_HOST=localhost \
     LC_ALL=C.UTF-8 \
     ANSIBLE_CONFIG=./ansible.cfg \
     ANSIBLE_INVENTORY=./inventories/hosts \
     ansible-playbook ./playbooks/playbook.yml
