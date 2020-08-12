#!/bin/bash -x

echo "Welcome to flip coin combination program"

read -p "How many times do you want to flip coin: " times

declare -A coin
counter=0
heads=0
tails=0

while [[ $counter != $times ]]
do
	face=$((RANDOM%2))

	if [[ $face = 1 ]]
	then
		((heads++))
	else
		((tails++))
	fi

	((counter++))
done

coin[H]=$heads
coin[T]=$tail

function facePercent ()
{
	local faceTimes=$1
	local total=$2

	per=`awk " BEGIN {print ($faceTimes/$total)*100 }"`
	echo "$per"
}

#Using subshell to run the function
echo "heads showed up $(facePercent $heads $times)% "
echo "tails showed up $(facePercent $tails $times)% "
