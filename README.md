# Vagrant Labs

Laboratórios configurados durante meu aprendizado em tecnologias DevOps

## Configurações lab Zabbix/Grafana:

|Máquina Virtual|Configurações|IP|
|:---:|:---:|:---:|
|zbx-server|CentOS 8, Grafana Server 8.5, Zabbix Server 6.0 (LTS), Apache e PostgreSQL/TimescaleDB|192.168.56.50/24|
|srv01|CentOS 8, Zabbix Agent 6.0.3|192.168.56.51/24|
|srv02|Windows Server 2019 Datacenter, Zabbix Agent 6.0.3|192.168.56.52/24|

|Máquina Virtual|Hardware|
|:---:|:---:|
|zbx-server|4Gb de memória e 4 CPU's|
|srv01|2Gb de memória e 2 CPU's|
|srv02|4Gb de memória e 4 CPU's|


**Usuário/Senha Zabbix frontend:** Admin/zabbix  | **Senha DB Zabbix:** Z4bb1xD4t4b4s3

## Configurações lab Kubernetes:

|Máquina Virtual|Configurações|IP|
|:---:|:---:|:---:|
|k8s|Ubuntu Server 20.04, Docker 20.10.14, Docker Compose 1.29.2, Kind 0.12.0, kubectl 1.23.6|192.168.56.10/24|

|Máquina Virtual|Hardware|
|:---:|:---:|
|k8s|8Gb de memória e 8 CPU's|

