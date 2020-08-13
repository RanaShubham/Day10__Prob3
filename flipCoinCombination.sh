#!/bin/bash -x

echo "Welcome to flip coin combination program"

read -p "How many times do you want to flip each of two coins: " times

declare -A coin
counter=0

coin["HH"]=0
coin["HT"]=0
coin["TH"]=0
coin["TT"]=0

#1 is tails and 2 is heads
while [[ $counter != $times ]]
do
	face1=$((1+RANDOM%2))
	face2=$((1+RANDOM%2))

	if [ $face1 -eq 1 -a $face2 -eq 1 ]
	then
		((coin["TT"]++))

	elif [ $face1 -eq 1 -a $face2 -eq 2 ]
	then
		((coin["TH"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 1 ]
	then
		((coin["HT"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 2 ]
	then
		((coin["HH"]++))
	fi

	((counter++))
done


function facePercent ()
{
	local faceTimes=$1
	local total=$2

	per=`awk " BEGIN {print ($faceTimes/$total)*100 }"`
	echo "$per"
}


echo "${coin[@]}"

#Using subshell to run the function
for key in ${!coin[@]}
do
	coin["$key"]="${coin["$key"]} times $(facePercent ${coin["$key"]} $times)%"

	echo "$key showed up ${coin["$key"]}"
done
