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
### Depois de modificar Vagrantfile ou arquivos auxiliares
```sh 
cd pasta-do-ambiente
vagrant reload --provision
```
### Acessar uma VM
```sh 
cd pasta-do-ambiente
vagrant ssh srv01 # Exemplo
```



