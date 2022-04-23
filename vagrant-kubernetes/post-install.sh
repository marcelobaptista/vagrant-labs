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
echo ''
echo '************************'
echo '*                      *'
echo '*   Configurando ZSH   *'
echo '*                      *'
echo '************************'
echo ''
cat <<"EOF"> /home/vagrant/.zshrc
export ZSH="/etc/oh-my-zsh"
ZSH_THEME="gianu"
DISABLE_AUTO_UPDATE="true"
plugins=(docker docker-compose git zsh-syntax-highlighting colorize command-not-found colored-man-pages common-aliases history-substring-search)
source /etc/oh-my-zsh/oh-my-zsh.sh
source <(kubectl completion zsh)
alias cls="clear"
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"
alias enable="sudo systemctl enable --now"
alias disable="sudo systemctl disable --now"
alias status="systemctl status"
alias kubectl="sudo kubectl"
autoload -Uz compinit
compinit
EOF
chown vagrant:vagrant /home/vagrant/.zshrc
chmod 775 /home/vagrant/.zshrc
usermod --shell /bin/zsh vagrant
echo ''
echo '***************************'
echo '*                         *'
echo '*   Configurando Chrony   *'
echo '*                         *'
echo '***************************'
echo ''
rm /etc/chrony/chrony.conf
cat <<"EOF"> /etc/chrony/chrony.conf
server a.st1.ntp.br iburst
server b.st1.ntp.br iburst
server c.st1.ntp.br iburst
server d.st1.ntp.br iburst
server a.ntp.br iburst
server b.ntp.br iburst
server c.ntp.br iburst
server gps.ntp.br iburst
keyfile /etc/chrony/chrony.keys
driftfile /var/lib/chrony/drift
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
makestep 1.0 3
rtcsync
leapsectz right/UTC
logdir /var/log/chrony
EOF
chmod 775 /etc/chrony/chrony.conf
systemctl restart chronyd
echo ''
echo '*************************'
echo '*                       *'
echo '*   Configurando Nano   *'
echo '*                       *'
echo '*************************'
echo ''
rm /etc/nanorc
cat <<"EOF"> /etc/nanorc
set autoindent
set linenumbers
set softwrap
set nowrap
set tabstospaces
set tabsize 2
set titlecolor blue
set statuscolor green
set errorcolor red
set selectedcolor magenta
set numbercolor cyan
set keycolor cyan
set functioncolor green
EOF
chmod 775 /etc/nanorc


