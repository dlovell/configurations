cat >> ~/.bash_aliases <<EOF
alias get-gateway='route -n | grep UG | awk "{print \\\$2}"'
alias nmap-scan='nmap -sn'
# nmap-scan \$(get-gateway)/24
#
alias tmux-eclimd='tmux new-session -d -s eclimd eclimd'
alias source-activate-latest='source activate $(conda env list | grep "^anaconda-[0-9]\{8\}" | cut -d" " -f1 | sort | tail -n 1)'
EOF
