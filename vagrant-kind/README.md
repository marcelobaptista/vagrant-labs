# Configurações do ambiente

|Máquina Virtual|Configurações|Hardware|IP|
|:---:|:---:|:---:|:---:|
|k8s-master|Ubuntu Server 20.04, Docker 20.10.14, Docker Compose 1.29.2, Kind 0.12.0, kubectl 1.23.6|8Gb RAM / 8 CPU's|192.168.56.10|

### Modificar recursos da máquina
Editar o arquivo Vagrantfile na pasta do ambiente:
```ruby 
kind.memory = 8192 # Memória
kind.cpus = 8 # CPU
kind.vm.network "private_network", ip: "192.168.56.10", :netmask => "255.255.255.0"

#private_network: rede interna VirtualBox, faixa de IP: 192.168.56.0/24 (4 primeiros são reservados)

#public_network: utiliza a rede do hospedeiro, deverá ser declarado qual a interface irá fazer bridge. 

#Exemplo de configuração: 

kind.vm.network "public_network", ip: "192.168.51.50", :netmask => "255.255.255.0", bridge: "ensp50"
```
