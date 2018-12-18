cat >> ~/.bash_aliases <<EOF
# configure_bash_aliases.sh
alias get-gateway='route -n | grep UG | awk "{print \\\$2}"'
alias nmap-scan='nmap -sn'
# nmap-scan \$(get-gateway)/24
#
alias tmux-eclimd='tmux new-session -d -s eclimd eclimd'
EOF
