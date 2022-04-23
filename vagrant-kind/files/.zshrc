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