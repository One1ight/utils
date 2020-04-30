#!/bin/bash

# read line from file one by one
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
len=${#arr[@]}
if [ $(( len % 2 )) !=  0 ]; then
	echo "parse error"
	exit 1
fi
> temp.txt
for (( i=0; i< len; i++ ));
do
	if [ $(( $i % 2 )) != 0 ]; then
		echo $i
		echo "${arr[i-1]}=your ${arr[i-1]}" >> temp.txt
	fi
done
