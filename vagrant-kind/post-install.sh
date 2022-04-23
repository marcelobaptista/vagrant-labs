systemctl disable --now ufw
echo ''
echo '*****************************************************'
echo '*                                                   *'
echo '*   Instalando e configurando pacotes adicionais    *'
echo '*                                                   *'
echo '*****************************************************'
echo ''
apt update && apt upgrade -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt install -y chrony nmap zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /etc/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
timedatectl set-timezone America/Sao_Paulo
localectl set-keymap br-abnt2
sed -i "s/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/" /etc/locale.gen
sed -i "s/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
mv /home/vagrant/chrony.conf /etc/chrony/chrony.conf
mv /home/vagrant/nanorc /etc/nanorc
usermod --shell /bin/zsh vagrant
systemctl restart chronyd


