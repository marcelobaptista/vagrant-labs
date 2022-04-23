# Configurações

- **zbx-server**: CentOS 8, Grafana 8.5, Zabbix 6.0 (LTS), Apache e PostgreSQL/TimescaleDB
- **srv01**: CentOS 8, Zabbix Agent 6.0.3
- **srv02**: Windows Server 2019 Datacenter, Zabbix Agent 6.0.3


|Máquina Virtual|Hardware|IP|Usuário/Senha Zabbix frontend:| Senha DB Zabbix: |
|:---:|:---:|:---:|:---:|:---:|
|zbx-server|4Gb de memória e 4 CPU's|192.168.56.50/24|Admin/zabbix|Z4bb1xD4t4b4s3|
|srv01|2Gb de memória e 2 CPU's|192.168.56.51/24|N/A|N/A|
|srv02|4Gb de memória e 4 CPU's|192.168.56.52/24|N/A|N/A|

Ao alterar o IP do Zabbix Server também deverá ser alterado os arquivos **post-install.ps1** e **install-zbx-agent.sh** nas seguintes seções:

- arquivo **install-zbx-agent.sh**
```sh
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
```
- arquivo **post-install.ps1**
```powershell
msiexec.exe /l*v zabbix_agent_install.log /i zabbix_agent-6.0.3-windows-amd64-openssl.msi /qn SERVER=192.168.56.50 LISTENPORT=10050 HOSTNAME=$nome SERVERACTIVE=192.168.56.50 ENABLEPATH=1
```

