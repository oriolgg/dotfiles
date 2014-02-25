# Common setup

export PATH=$PATH:/opt/local/bin:/opt/local/sbin

# Posar al títol de la tab el nom de directori i nom del fitxer
myVim() {
	echo -ne "\033]0;${PWD##*/}/$1\007"
	vim $1
}
alias vim=myVim

