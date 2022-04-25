# Configurações do ambiente

|Máquina Virtual|Configurações|Hardware|IP|
|:---:|:---:|:---:|:---:|
|k8s-master|Ubuntu Server 20.04, Docker 20.10.7, containerd.io 1.4.6, Kubernetes v1.23.6|8Gb RAM / 8 CPU's|192.168.56.10|
|k8s-node01|Ubuntu Server 20.04, Docker 20.10.7, containerd.io 1.4.6, Kubernetes v1.23.6|2Gb RAM / 2 CPU's|192.168.56.11|
|k8s-node02|Ubuntu Server 20.04, Docker 20.10.7, containerd.io 1.4.6, Kubernetes v1.23.6|2Gb RAM / 2 CPU's|192.168.56.12|

### Modificar recursos da máquina
Editar o arquivo Vagrantfile na pasta do ambiente:
```ruby 
kind.memory = 8192 # Memória
kind.cpus = 8 # CPU
kind.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.255.0" # IP da máquina virtual

#private_network: rede interna VirtualBox, faixa de IP: 192.168.56.0/24 (4 primeiros são reservados)

#public_network: utiliza a rede do hospedeiro, deverá ser declarado qual a interface irá fazer bridge. 

#Exemplo de configuração: 

kind.vm.network "public_network", ip: "192.168.51.50", :netmask => "255.255.255.0", bridge: "ensp50"
```
