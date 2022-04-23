echo ''
echo '*****************************************'
echo '*                                       *'
echo '*   Instalando e configurando Docker    *'
echo '*                                       *'
echo '*****************************************'
echo ''
apt install -y apt-transport-https docker.io
systemctl enable --now docker.service
usermod -aG docker vagrant
curl -L "https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo ''
echo '*************************************************'
echo '*                                               *'
echo '*   Instalando e configurando Kind & kubectl    *'
echo '*                                               *'
echo '*************************************************'
echo ''
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt update && apt install -y kubectl
apt autoremove -y
cat << EOF > /home/vagrant/kind-4nodes.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
  - role: worker
EOF
kind create cluster --name kind-multinodes --config /home/vagrant/kind-4nodes.yaml