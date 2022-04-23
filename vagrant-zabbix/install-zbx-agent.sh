echo '*************************************'
echo '*                                   *'
echo '*   Instalando repositório Zabbix   *'
echo '*                                   *'
echo '*************************************'
echo ''
rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-1.el8.noarch.rpm
echo ''
echo '***********************************************'
echo '*                                             *'
echo '*   Instalando e configurando Zabbix Agent    *'
echo '*                                             *'
echo '***********************************************'
echo ''
dnf -y install zabbix-agent zabbix-selinux-policy zabbix-sender
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
nome=$(hostname)
sed -i "s/Hostname=Zabbix server/Hostname=$nome/" /etc/zabbix/zabbix_agentd.conf
systemctl enable --now zabbix-agent
echo ''
echo '***************************'
echo '*                         *'
echo '*   Executando limpeza    *'
echo '*                         *'
echo '***************************'
echo ''
dnf -y clean all
rm -rf /var/cache/yum /var/lib/yum/yumdb/* /usr/lib/udev/hwdb.d/*
rm -rf /var/cache/dnf /etc/udev/hwdb.bin /root/.pki



