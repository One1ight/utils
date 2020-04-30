#!/bin/bash

# read file and split each line by delimeter("=")
# append each line result to array
filename='test.txt'
delm='='
arr=();
while read line;do
	s=$line$delm
	while [[ $s ]]; do
		arr+=( "${s%%"$delm"*}" );
		s=${s#*"$delm"};
	done
done < $filename
declare -p arr

# valid check, 
# because .env file just key value pairs, so the length would be even
len=${#arr[@]}
if [ $(( len % 2 )) !=  0 ]; then
	echo "parse error"
	exit 1
fi
# empty file content
> temp.txt
# find key and append to file
for (( i=0; i< len; i++ ));
do
	if [ $(( $i % 2 )) != 0 ]; then
		echo $i
		echo "${arr[i-1]}=your ${arr[i-1]}" >> temp.txt
	fi
done
