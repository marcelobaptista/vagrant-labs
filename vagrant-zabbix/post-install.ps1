mkdir C:\Zabbix
cd C:\Zabbix
Invoke-WebRequest -Uri https://cdn.zabbix.com/zabbix/binaries/stable/6.0/6.0.3/zabbix_agent-6.0.3-windows-amd64-openssl.msi -OutFile c:\Zabbix\zabbix_agent-6.0.3-windows-amd64-openssl.msi
$nome = iex hostname
# ao alterar o IP do Zabbix Server também deverá ser alterado na linha abaixo
msiexec.exe /l*v zabbix_agent_install.log /i zabbix_agent-6.0.3-windows-amd64-openssl.msi /qn `
SERVER=192.168.56.50 LISTENPORT=10050 HOSTNAME=$nome SERVERACTIVE=192.168.56.60 ENABLEPATH=1
Set-TimeZone -Id 'E. South America Standard Time'
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False