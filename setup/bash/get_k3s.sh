#!/bin/bash

curl -sfL https://get.k3s.io | sh -s -
echo -e KUBECONFIG=/etc/rancher/k3s/k3s.yaml | tee -a /etc/environment
