#!/bin/bash

# Configurações do SO (remoção de pacotes, timezone, etc)
apt-get update && apt-get upgrade -y
apt-get purge -y ufw snapd && apt-get install -y apt-transport-https chrony
timedatectl set-timezone America/Sao_Paulo
mv /home/vagrant/chrony.conf /etc/chrony/chrony.conf && systemctl restart chronyd
# Configura o arquivo hosts
cat <<EOF | tee /etc/hosts
192.168.57.10   c1-cp1
192.168.57.11   c1-node1
192.168.57.12   c1-node2
192.168.57.13   c1-node3
192.168.57.14   c1-node4
192.168.57.15   c1-node5
192.168.57.16   c1-node6
192.168.57.17   c1-node7
EOF
# Desativa swap e remove qualquer entrada  para partições swap em /etc/fstab
swapoff -a && sed -i '/ swap / s/^/#/' /etc/fstab
# Pré-requisitos do containerd, carrega os módulos necessários e configura para carregar na inicialização
# Para mais informações:
# Info: https://kubernetes.io/docs/setup/production-environment/container-runtimes/
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
modprobe overlay && modprobe br_netfilter
# Parâmetros sysctl exigidos pela configuração
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
# Aplica parâmetros sysctl sem reiniciar
sysctl --system
# Configura os repositórios para instalação do containerd, kubeadm, kubelet e kubectl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |
  tee /etc/apt/sources.list.d/kubernetes.list
# Instalação do containerd
apt-get update && apt-get install -y containerd.io
#Cria um arquivo de configuração containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
# Define o driver cgroup para containerd como systemd, que é necessário para o kubelet.
# Para mais informações sobre este arquivo de configuração:
# https://github.com/containerd/cri/blob/master/docs/config.md
# https://github.com/containerd/containerd/blob/master/docs/ops.md
sed -i 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
# Instalação do kubeadm, kubelet e kubectl
VERSION=1.26.0-00
apt-get install -y kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION
# Limpeza do apt
apt-get clean && apt-get autoremove
# Marca os pacotes kubelet kubeadm kubectl containerd para não serem atualizados automaticamente pelo apt
apt-mark hold kubelet kubeadm kubectl containerd
# Habilita os serviços necessários
systemctl enable --now kubelet.service containerd.service
