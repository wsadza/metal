Ansible - Local Development 
============
This repository serves as a automation of creating local development setup.

## ⚙️  Ansible Roles 

Definied ansible roles.

- `python` - Install python, which is need to run later jobs, 
- `misc` - Lists of packages which will be installed on given target,
- `act` - Run github actions localy,
- `docker` - Container technology,
- `terraform` - Provisioning,
- `helm` - Kubernetes package manger,
- `neovim` - Improved vim
- `kubectl` - Kubernetes client, 
- `k9s` - Kubernetes IDE,
- `k3d` - Kubernetes on top of docker engine.

## 🗄 Repository structure

- `./ansible` - Ansible main directory,
- `./ansible/playbooks` - Home of main ansible playbook,
- `./ansible/roles` - Ansible roles,
- `./ansible/inventories` - Ansible inventory - targets.

## 🔖 Versioning model

Versions have the format `<MAJOR>.<MINOR>(.<PATCH>)?` where:

- `<MAJOR>` Triggered manualy from default branch,
- `<MINOR>` Triggered automaticly after each push from default branch,
- `<PATCH>` Triggered automaticly after each push from fix/[0-9].[0-9].x branch.
