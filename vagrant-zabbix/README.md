# Configurações do ambiente

|Máquina Virtual|Configurações|Hardware|IP|
|:---:|:---:|:---:|:---:|
|zbxserver|CentOS 8, Grafana 8.5, Zabbix 6.0.3, Apache, PostgreSQL/TimescaleDB|4GB RAM / 4 CPU's|192.168.56.50|
|zbxproxy|CentOS 8, Zabbix Proxy 6.0.3, SQLite 3|2GB RAM / 2 CPU's|192.168.56.60|
|srv01|CentOS 8, Zabbix Agent 6.0.3|2GB RAM / 2 CPU's|192.168.56.51|
|srv02|Windows Server 2019 Datacenter, Zabbix Agent 6.0.3|4GB RAM / 4 CPU's|192.168.56.52|

### Modificar recursos da máquina
Editar o arquivo Vagrantfile na pasta do ambiente:
```ruby 
zbxserver.memory = 4096 # Memória
zbxserver.cpus = 4 # CPU
zbxserver.vm.network "private_network", ip: "192.168.56.50", :netmask => "255.255.255.0" # IP da máquina virtual

#private_network: rede interna VirtualBox, faixa de IP: 192.168.56.0/24 (4 primeiros são reservados)

#public_network: utiliza a rede do hospedeiro, deverá ser declarado qual a interface irá fazer bridge. 

#Exemplo de configuração: 

zbxserver.vm.network "public_network", ip: "192.168.51.50", :netmask => "255.255.255.0", bridge: "ensp50"
```

Ao alterar o IP do Zabbix Server também deverá ser alterado os respectivos campos nos arquivos **install-proxy.sh**, **install-zbx-agent.sh** e **post-install.ps1** nas seguintes seções:

- arquivo **install-proxy.sh**
```sh
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_proxy.conf

sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
```
- arquivo **install-zbx-agent.sh**
```sh
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf

sed -i "s/ServerActive=127.0.0.1/ServerActive=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
```
- arquivo **post-install.ps1**
```powershell
msiexec.exe /l*v zabbix_agent_install.log /i zabbix_agent-6.0.3-windows-amd64-openssl.msi /qn `
SERVER=192.168.56.50 LISTENPORT=10050 HOSTNAME=$nome SERVERACTIVE=192.168.56.50 ENABLEPATH=1
```

