alias deactivate_wireless='rfkill block all; if [[ $! ]]; then; echo "check if rfkill is installed"; fi'
alias whereami='dig +short myip.opendns.com @resolver1.opendns.com'
alias show_net_entries='/usr/sbin/arp -e -n' # }-extend-{
alias dump_connections='netstat -a46n'
alias dump_listen_connections='netstat -a46nc'

function kill_from_port(){
	port=$1; lsof -i:$port | grep $port | awk '{print $2}' | xargs kill
}

function demux_balancers(){
	ports=$1
	ip=$2
	hing2 -c 10 -i 1 -p $ip -S $ports
}
