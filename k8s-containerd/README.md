# Configurações do ambiente

|Máquina Virtual|Configurações|Hardware|IP|
|:---:|:---:|:---:|:---:|
|c1-cp1|Ubuntu Server 22.04, containerd.io 1.6.18, Kubernetes v1.26.0|8Gb RAM / 8 CPU's|192.168.56.10|
|c1-node1|Ubuntu Server 22.04, containerd.io 1.6.18, Kubernetes v1.26.0|2Gb RAM / 2 CPU's|192.168.56.11|
|c1-node2|Ubuntu Server 22.04, containerd.io 1.6.18, Kubernetes v1.26.0|2Gb RAM / 2 CPU's|192.168.56.12|

# Modificar recursos da máquina

Editar o arquivo Vagrantfile:
```ruby
cp.memory = 8192 # Memória do Control Plane
cp.cpus = 8 # CPU do Control Plane
cp.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.255.0"

# IP do Control Plane de acordo com o CIDR Virtualbox  (4 primeiros da rede são reservados)
# private_network: rede interna VirtualBox, no exemplo está configurado o CIDR 192.168.56.0/24
# Ao mudar o IP, alterar também os arquivos configura_cp.sh e instala_containerd.sh
```
