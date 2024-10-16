#!/bin/bash

# https://github.com/l7mp/stunner

# install strunner 
helm repo add stunner https://l7mp.io/stunner
helm repo update
helm install stunner-gateway-operator stunner/stunner-gateway-operator \
  --create-namespace \
  --namespace=stunner 

# configure stunner
# -------------------------

kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: stunner-gatewayclass
spec:
  controllerName: "stunner.l7mp.io/gateway-operator"
  parametersRef:
    group: "stunner.l7mp.io"
    kind: GatewayConfig
    name: stunner-gatewayconfig
    namespace: stunner
  description: "STUNner is a WebRTC media gateway for Kubernetes"
EOF

# -------------------------

kubectl apply -f - <<EOF
apiVersion: stunner.l7mp.io/v1
kind: GatewayConfig
metadata:
  name: stunner-gatewayconfig
  namespace: stunner
spec:
  realm: anykey.pl 
  authType: plaintext
  userName: "user"
  password: "pass"
EOF

# -------------------------
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: udp-gateway
  namespace: stunner
spec:
  gatewayClassName: stunner-gatewayclass
  listeners:
    - name: udp-listener
      port: 3478
      protocol: TURN-UDP
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: tcp-gateway
  namespace: stunner
spec:
  gatewayClassName: stunner-gatewayclass
  listeners:
    - name: tcp-listener
      port: 3478
      protocol: TURN-TCP
---
apiVersion: stunner.l7mp.io/v1
kind: UDPRoute
metadata:
  name: stunner-headless
  namespace: stunner
spec:
  parentRefs:
    - name: udp-gateway
    - name: tcp-gateway
  rules:
    - backendRefs:
        - name: metal 
          namespace: default 
---
apiVersion: stunner.l7mp.io/v1
kind: Dataplane
metadata:
  name: default
  namespace: stunner
spec:
  command:
  - stunnerd
  args:
  - -w
  - --udp-thread-num=16
  image: l7mp/stunnerd:latest
  resources:
    limits:
      cpu: 2
      memory: 512Mi
    requests:
      cpu: 500m
      memory: 128Mi
  terminationGracePeriodSeconds: 3600
  hostNetwork: true
EOF
