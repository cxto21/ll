# aliases
##sysctl
alias poweroff="systemctl poweroff"
alias reboot="systemctl reboot"
alias suspend="systemctl suspend"

##pbcopy & pbpaste
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# file navegation
##access and list
function dsls(){
  if [ -d $1 ]; then
    cd $1; ls;
  else
    echo "The directory $1 does not exist"
  fi
}

##create and access
function mkGetin {
  local newDir=$1;
  if [ -d $newDir ]; then
    echo "The directory '$newDir' already exists"
  else
    mkdir -p $1 && cd $1 && touch descriptor.md;
  fi
}


