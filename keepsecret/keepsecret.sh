#!/bin/bash
set -e
set -u
set -o pipefail

# TODO find .env file in .gitignore file or or maybe add .env to .ignore
# srcname and dstname
srcname='db.dev.env'
suffix='.env'
result=${srcname%%"$suffix"*}
example='.example'
dstname=$result$example$suffix

# read file and split each line by delimeter("=")
# append each line result to array
delm='='
arr=();
while read line; do
	s=$line$delm
	while [[ $s ]]; do
		arr+=( "${s%%"$delm"*}" );
		s=${s#*"$delm"};
	done
done < $srcname
declare -p arr

# valid check, 
# because .env file just key value pairs
# so the length would be even :)so easy???
len=${#arr[@]}
if [ $(( len % 2 )) !=  0 ]; then
	echo "parse error"
	exit 1
fi

# empty file content
> $dstname

# find key and append to file
for (( i=0; i< len; i++ ));
do
	if [ $(( $i % 2 )) != 0 ]; then
		echo $i
		echo "${arr[i-1]}=your ${arr[i-1]}" >> $dstname
	fi
done
