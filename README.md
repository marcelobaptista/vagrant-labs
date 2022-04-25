# Vagrant Labs

Laboratórios configurados durante meu aprendizado em tecnologias DevOps (em andamento)

## Como usar?
```sh 
git clone https://github.com/marcelobaptista/vagrant-labs.git
```
### Iniciar o ambiente Zabbix/Grafana:
```sh 
cd vagrant-labs/vagrant-zabbix
vagrant up
```
### Iniciar o ambiente  Kubernetes
```sh 
cd vagrant-labs/vagrant-kubernetes
vagrant up
```
### Desligar um ambiente
```sh 
cd pasta-do-ambiente
vagrant halt
```
### Destruir um ambiente
```sh 
cd pasta-do-ambiente
vagrant destroy -f
```
### Modificar recursos das máquinas
Editar o arquivo Vagrantfile na pasta do ambiente:
```ruby 
zbxserver.memory = 4096 # Memória
zbxserver.cpus = 4 # CPU
zbxserver.vm.network "private_network", ip: "192.168.56.50", :netmask => "255.255.255.0"
#private_network: rede interna VirtualBox, faixa de IP: 192.168.56.0/24 (4 primeiros são reservados)
#public_network: utiliza a rede do hospedeiro, deverá ser declarado qual a interface irá fazer bridge. 
#Exemplo de configuração: 
#zbxserver.vm.network "public_network", ip: "192.168.51.50", :netmask => "255.255.255.0", bridge: "ensp50"
```



