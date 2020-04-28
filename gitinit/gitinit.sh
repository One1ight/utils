#!/bin/bash
set -e
set -u
set -o pipefail

owner=''
name=''
function help() {
	echo "gitinit is a little script to help you create a new repository on the command line"
	echo "But first you need to create a remote bare respository and leave the rest to gitinit"
	usage
	exit 1
}
function usage(){
	printf "script usage:\n\t[-v] version\n \t[-o owner] set owner\n\t[-n repositoryName] set repository name\n"
}
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
if [ -z $owner ] ; then 
	owner=$(whoami)	
fi
if [ -z $name ] ; then
	name=${PWD##*/}
fi
echo "The owner will be :$owner."
echo "The respositoryName will be :$name."

echo -n "Are you sure?(y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	echo "*******************README.md***********************"
	echo "#$name" >> README.md
	echo "*******************git init************************"
	git init
	echo "***************git add README.md*******************"
	git add README.md
	echo "******************first commit*********************"
	git commit -m "first commit"
	echo "***************remote add origin*******************"
	git remote add origin https://github.com/$owner/$name.git
	echo "***************push origin master******************"
	git push -u origin master
	echo "**********************end**************************"
else
	exit 1
fi

