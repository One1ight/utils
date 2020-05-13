#!/bin/bash
set -e
set -u
set -o pipefail

owner=''
name=''
# help print info and usage
function help() {
	echo "gitinit is a little script to help you create a new repository on the command line"
	echo "But first you need to create a remote bare repository and leave the rest to gitinit"
	usage
	exit 1
}
# usage print usage
function usage(){
	printf "script usage:\n\t[-v] version\n \t[-o owner] set owner\n\t[-n repositoryName] set repository name\n"
}
# get options( owner, repository name.)
while getopts 'vho:n:' OPTION; do
	case "$OPTION" in
		v)
			echo "v0.0.1"
			;;
		o)
			owner="$OPTARG"
			echo "owner is $OPTARG"
			;;
		h)
			help
			;;
		n)
			name="$OPTARG"
			echo "repository name is $OPTARG"
			;;
		?)
			echo "script usage: $(0) [-v] [-o owner] [-n repositoryName]" >&2
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))"
# set owner if not exist
if [ -z $owner ] ; then 
	owner=$(whoami)	
fi
# set repository name if not exist
if [ -z $name ] ; then
	name=${PWD##*/}
fi
# print owner and repository
echo "The owner will be :$owner."
echo "The repositoryName will be :$name."

# continue or exit
echo -n "Are you sure?(y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then

	# execute git command
	echo "*******************README.md***********************"
	echo "#$name" >> README.md
	echo "*******************git init************************"
	git init
	echo "***************git add README.md*******************"
	git add README.md
	echo "******************first commit*********************"
	git commit -m "first commit"
	echo "***************remote add origin*******************"
	git remote add origin git@github.com:$owner/$name.git
	echo "***************push origin master******************"
	git push -u origin master
	echo "**********************end**************************"
else
	exit 1
fi

