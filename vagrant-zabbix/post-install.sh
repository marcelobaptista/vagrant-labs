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
plugins=(git zsh-syntax-highlighting colorize command-not-found colored-man-pages common-aliases history-substring-search)
source /etc/oh-my-zsh/oh-my-zsh.sh
alias cls="clear"
alias start="sudo systemctl start"
alias restart="sudo systemctl restart"
alias stop="sudo systemctl stop"
alias enable="sudo systemctl enable --now"
alias disable="sudo systemctl disable --now"
alias status="systemctl status"
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
rm /etc/chrony.conf
cat <<"EOF"> /etc/chrony.conf
server a.st1.ntp.br iburst
server b.st1.ntp.br iburst
server c.st1.ntp.br iburst
server d.st1.ntp.br iburst
server a.ntp.br iburst
server b.ntp.br iburst
server c.ntp.br iburst
server gps.ntp.br iburst
keyfile /etc/chrony.keys
driftfile /var/lib/chrony/drift
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
makestep 1.0 3
rtcsync
leapsectz right/UTC
logdir /var/log/chrony
EOF
chmod 775 /etc/chrony.conf
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
