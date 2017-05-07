cat >> ~/.bash_aliases <<EOF
alias get-gateway='route -n | grep UG | awk "{print \\\$2}"'
alias nmap-scan='nmap -sn'
# nmap-scan \$(get-gateway)/24
alias radio-all-on='nmcli radio all on'
alias radio-all-off='nmcli radio all off'
alias connection-up='nmcli connection up'
EOF
