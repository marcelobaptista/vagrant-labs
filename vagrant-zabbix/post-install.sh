echo '******************************'
echo '*                            *'
echo '*   Desabilitando SELinux    *'
echo '*                            *'
echo '******************************'
echo ''
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
setenforce 0
echo ''
echo '******************************'
echo '*                            *'
echo '*   Desabilitando Firewall   *'
echo '*                            *'
echo '******************************'
echo ''
systemctl disable --now firewalld
echo ''
echo '*****************************************************'
echo '*                                                   *'
echo '*   Instalando e configurando pacotes adicionais    *'
echo '*                                                   *'
echo '*****************************************************'
echo ''
dnf update -y
dnf install -y nano git htop langpacks-pt_BR nmap rsync zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /etc/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
timedatectl set-timezone America/Sao_Paulo
localectl set-keymap br-abnt2
localectl set-locale LANG=pt_BR.utf8
usermod --shell /bin/zsh vagrant
mv /home/vagrant/chrony.conf /etc/chrony.conf
mv /home/vagrant/nanorc /etc/nanorc
systemctl restart chronyd