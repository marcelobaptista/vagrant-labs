echo ''
echo '*************************************'
echo '*                                   *'
echo '*   Instalando repositório Zabbix   *'
echo '*                                   *'
echo '*************************************'
echo ''
rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-1.el8.noarch.rpm
echo ''
echo '************************************************'
echo '*                                              *'
echo '*   Instalando e configurando Zabbix Proxy     *'
echo '*                                              *'
echo '************************************************'
echo ''
dnf -y install epel-release
dnf -y install sqlite zabbix-proxy-sqlite3 zabbix-sql-scripts zabbix-selinux-policy
mkdir /var/lib/sqlite/
cat /usr/share/doc/zabbix-sql-scripts/sqlite3/proxy.sql | sqlite3 /var/lib/sqlite/zabbix.db
chown -R zabbix:zabbix /var/lib/sqlite/
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_proxy.conf
sed -i "s/# ConfigFrequency=3600/ConfigFrequency=500/" /etc/zabbix/zabbix_proxy.conf
sed -i "s/DBName=zabbix_proxy/DBName=\/var\/lib\/sqlite\/zabbix.db/" /etc/zabbix/zabbix_proxy.conf
systemctl enable --now zabbix-proxy
echo ''
echo '***********************************************'
echo '*                                             *'
echo '*   Instalando e configurando Zabbix Agent    *'
echo '*                                             *'
echo '***********************************************'
echo ''
dnf -y install zabbix-agent
sed -i "s/Server=127.0.0.1/Server=192.168.56.50/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/Hostname=Zabbix proxy/" /etc/zabbix/zabbix_agentd.conf
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
