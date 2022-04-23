echo '*********************************************'
echo '*                                           *'
echo '*   Instalando e configurando PostgreSQL    *'
echo '*                                           *'
echo '*********************************************'
echo ''
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -y module disable postgresql
dnf install -y postgresql14-server
/usr/pgsql-14/bin/postgresql-14-setup initdb
sed -i "s/ident/md5/g" /var/lib/pgsql/14/data/pg_hba.conf
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/14/data/postgresql.conf
systemctl enable --now postgresql-14
echo ''
echo '************************************'
echo '*                                  *'
echo '*   Criando DB e usuário zabbix    *'
echo '*                                  *'
echo '************************************'
echo ''
sudo -u postgres psql -c "CREATE USER zabbix WITH ENCRYPTED PASSWORD 'Z4bb1xD4t4b4s3'" 2>/dev/null
sudo -u postgres createdb -O zabbix -E Unicode -T template0 zabbix 2>/dev/null
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
echo '*   Instalando e configurando Zabbix Server    *'
echo '*                                              *'
echo '************************************************'
echo ''
dnf -y install zabbix-server-pgsql zabbix-web-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent zabbix-get zabbix-sender
zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix PGPASSWORD=Z4bb1xD4t4b4s3 psql -hlocalhost -Uzabbix zabbix 2  dev/null
sed -i "s/# DBHost=localhost/DBHost=localhost/" /etc/zabbix/zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=Z4bb1xD4t4b4s3/" /etc/zabbix/zabbix_server.conf
systemctl enable --now zabbix-server
echo "php_value[date.timezone] = America/Sao_Paulo" >> /etc/php-fpm.d/zabbix.conf
cat <<"EOF">  /etc/zabbix/web/zabbix.conf.php
  <?php
      $DB["TYPE"]			= "POSTGRESQL";
      $DB["SERVER"]			= "localhost";
      $DB["PORT"]			= "5432";
      $DB["DATABASE"]		= "zabbix";
      $DB["USER"]			= "zabbix";
      $DB["PASSWORD"]		= "Z4bb1xD4t4b4s3";
      $DB["SCHEMA"]			= "";
      $DB["ENCRYPTION"]		= false;
      $DB["KEY_FILE"]		= "";
      $DB["CERT_FILE"]		= "";
      $DB["CA_FILE"]		= "";
      $DB["VERIFY_HOST"]	= false;
      $DB["CIPHER_LIST"]	= "";
      $DB["VAULT_URL"]		= "";
      $DB["VAULT_DB_PATH"]	= "";
      $DB["VAULT_TOKEN"]	= "";
      $DB["DOUBLE_IEEE754"]	= true;
      $ZBX_SERVER			= "localhost";
      $ZBX_SERVER_PORT		= "10051";
      $ZBX_SERVER_NAME		= "zabbix";
      $IMAGE_FORMAT_DEFAULT	= IMAGE_FORMAT_PNG;
EOF
ln -s /etc/zabbix/web/zabbix.conf.php /usr/share/zabbix/conf/zabbix.conf.php
ln -s /etc/zabbix/web/maintenance.inc.php /usr/share/zabbix/conf/maintenance.inc.php
echo ''
echo '***********************************************'
echo '*                                             *'
echo '*   Iniciando php-fpm, zabbix-agent, httpd    *'
echo '*                                             *'
echo '***********************************************'
echo ''
systemctl enable --now php-fpm
systemctl enable --now httpd
systemctl enable --now zabbix-agent
echo ''
echo '**********************************************'
echo '*                                            *'
echo '*   Instalando e configurando TimescaleDB    *'
echo '*                                            *'
echo '**********************************************'
echo ''
dnf -y install timescaledb_14
systemctl stop zabbix-server
echo "shared_preload_libraries = 'timescaledb'" > /var/lib/pgsql/14/data/postgresql.conf
systemctl restart postgresql-14
echo "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;" | sudo -u postgres psql zabbix 2>/dev/null
cat /usr/share/doc/zabbix-sql-scripts/postgresql/timescaledb.sql | sudo -u zabbix psql zabbix 2>/dev/null
echo ''
echo '********************************'
echo '*                              *'
echo '*   Iniciando zabbix-server    *'
echo '*                              *'
echo '********************************'
echo ''
systemctl start zabbix-server