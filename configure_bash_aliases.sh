cat >> ~/.bash_aliases <<EOF
alias get-gateway='route -n | grep UG | awk "{print \\\$2}"'
alias nmap-scan='nmap -sn'
# nmap-scan \$(get-gateway)/24
alias radio-all-on='nmcli radio all on'
alias radio-all-off='nmcli radio all off'
alias connection-up='nmcli connection up'
alias device-wifi-list='nmcli device wifi list'
alias device-wifi-connect='nmcli device wifi connect'
#
alias tmux-eclimd='tmux new-session -d -s eclimd eclimd'
alias tmux-pasuspender='tmux new-session -d -s pasuspender pasuspender -- sleep 10000000000'
alias source-activate-latest='source activate $(conda env list | grep "^anaconda-[0-9]\{8\}" | cut -d" " -f1 | sort | tail -n 1)'
EOF
