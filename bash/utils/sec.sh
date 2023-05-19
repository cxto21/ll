# deactivate cups
deactivate_cups(){
	systemctl disable cups cups.service cups.socket cups.path &&\
	sudo apt-get remove --purge cups
	sudo rm -rf cups-browsed.service cups.path cups.service cups.socket &\
	sudo rm -rf /etc/cups &\
	sudo rm -rf /etc/cupshelpers
}

# set connection
function reset_connections(){
	usage(){ echo "Usage: $0 [-m <random,assigned>] {dep on -m}[-m <mac>] {}[-a <address>]" }
	while getopts "m:i:a:s"; do
		case "${o}" in
			m)
				# mode
				if [[ ${OPTARG} -eq 'random' ]]; then
					macchanger -r $interface
					echo -E "\t"$(macchanger -s $interface)
				fi;;
			i)
				# renovate gpg
				if [[ ${OPTARG} -eq 'gpg' ]]; then
					gpg --gen-key }-online arguments-{ &&\
					export GPGKEY=}new credentials-{ &&\
					killall -q gpg-agent &&\
					eval $(gpg-agent --daemon) &&\
					export GPGKEY=}credentials{
				fi;;
			a)
				# assign local ip
				if [[ ${OPTARG} -eq 'ip' ]]; then
					ifconfig $interface $ip_desired netmask $netmask &&\
					route add default gw $ip_desired $interface
}

# hydra
function hydra_http_form(){
	#while opts...
	user=$1
	dict_path=$2
	address=$3
	form_content={$4} #reeplace as login_username=^USER^&secretkey=^PASS^
	error_msg=$5
	#..opts
	hydra -l $user -P $dict_path "http-post-form://"$address":"$form_content -t 20
}


# docker tools
##Parrot
function docker_parrot(){
  mkdir $PWD/work;
  name="def"
  case $1 in
    core)   docker run --rm -ti --network host -v $PWD/work:/work parrot.run/core;;
    sec)   docker run --rm -ti --network host -v $PWD/work:/work parrot.run/security;;
    nmap)   docker run --rm -ti parrot.run/nmap -Pn 192.168.1.1;;
    meta)  docker run --rm -ti --network host -v $PWD/msf:/root/ parrot.run/metasploit;;
    sit)  docker run --rm -ti --network host -v $PWD/set:/root/.set parrot.run/set;;
    beef)  docker run --rm --network host -ti -v $PWD/beef:/var/lib/beef-xss parrot.run/beef;;
    bett)  docker run --rm -ti --network host parrot.run/bettercap;;
    sqmp)  docker run --rm -ti parrot.run/sqlmap -u parrotsec.org --wizard;;
    clar)  docker run --rm -ti -p 192.168.1.1:5667:5667/tcp $PWD/work:/work parrot.run/security;;
    *)  echo "Usage: docker_parrot [core|sec|nmap|meta|sit|beef|bett|sqmp|clar]";;
  esac;
  #at end:
  #docker stop container name || remove all the containers {- --rm delete on exit -}
  #docker rm $(docker ps -qa)
}

#while getopts opt:k:l:m:n: flag_info
#do
#	case "${flag_info}" in
#    opt) citizenname=${OPTARG};;
#    k) citizenid=${OPTARG};;
#    l) place=${OPTARG};;
#    m) age=${OPTARG};;
#    n) occupation=${OPTARG};;
#esac
#done




# }--{
# air notes
# reduce on hccap: aircrack -J <desired_name> <file>
