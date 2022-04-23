echo '******************************************'
echo '*                                        *'
echo '*   Instalando e configurando Grafana    *'
echo '*                                        *'
echo '******************************************'
echo ''
dnf install -y urw-fonts
wget https://dl.grafana.com/oss/release/grafana-8.5.0-1.x86_64.rpm
yum install -y grafana-8.5.0-1.x86_64.rpm
rm -f grafana-8.5.0-1.x86_64.rpm
systemctl daemon-reload
systemctl enable --now grafana-server
grafana-cli plugins install alexanderzobnin-zabbix-app
systemctl restart grafana-server
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

