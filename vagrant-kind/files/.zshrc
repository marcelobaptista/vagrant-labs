export ZSH="/etc/oh-my-zsh"
ZSH_THEME="gianu"
DISABLE_AUTO_UPDATE="true"
plugins=(docker docker-compose git zsh-syntax-highlighting colorize command-not-found colored-man-pages common-aliases history-substring-search)
source <(kubectl completion zsh)
source /etc/oh-my-zsh/oh-my-zsh.sh
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