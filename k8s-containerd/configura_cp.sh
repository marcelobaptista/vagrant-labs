#!/bin/bash

#Inicia o cluster
kubeadm init --kubernetes-version v1.26.0 --ignore-preflight-errors all \
    --apiserver-advertise-address=192.168.56.10 \
    --apiserver-cert-extra-sans=192.168.56.10 \
    --node-name c1-cp1 \
    --pod-network-cidr=192.168.0.0/16
#Cria Pod Network com Calico
runuser -l vagrant -c \
    'kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/tigera-operator.yaml'
#Configura o Control Plane para ter acesso administrativo ao servidor API a partir de uma conta não privilegiada.
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant /home/vagrant/.kube/config
#Gera token e salva o comando join no formato apropriado no arquivo join.sh
if [ -f "./k8s/join.sh" ]; then
    rm ./k8s/join.sh
    kubeadm token create --print-join-command >./k8s/join.sh
    chmod +x ./k8s/join.sh
else
    kubeadm token create --print-join-command >./k8s/join.sh
    chmod +x ./k8s/join.sh
fi
