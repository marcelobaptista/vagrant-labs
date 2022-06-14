# Vagrant Labs

Laboratórios configurados durante meu aprendizado em tecnologias DevOps (em andamento)

## Pré-requisitos

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Como usar?
```sh
git clone https://github.com/marcelobaptista/vagrant-labs.git
```
### Iniciar o ambiente Zabbix/Grafana:
```sh 
cd vagrant-labs/vagrant-zabbix
vagrant up
```
### Iniciar o ambiente k8s
```sh 
cd vagrant-labs/vagrant-k8s-ansible
vagrant up
```
### Desligar um ambiente
```sh 
cd pasta-do-ambiente
vagrant halt
```
### Desligar uma máquina
```sh 
cd pasta-do-ambiente
vagrant halt srv01 # Exemplo
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



