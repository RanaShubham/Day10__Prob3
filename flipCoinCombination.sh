#!/bin/bash -x

echo "Welcome to flip coin combination program"

read -p "How many times do you want to flip each of three coins: " times

declare -a storeDict
declare -A coin
counter=0

coin["HHH"]=0
coin["HTH"]=0
coin["THH"]=0
coin["TTH"]=0
coin["TTT"]=0
coin["THT"]=0
coin["HTT"]=0
coin["HHT"]=0



#1 is tails and 2 is heads
while [[ $counter != $times ]]
do
	face1=$((1+RANDOM%2))
	face2=$((1+RANDOM%2))
	face3=$((1+RANDOM%2))

	if [ $face1 -eq 1 -a $face2 -eq 1 -a $face3 = 1 ]
	then
		((coin["TTT"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 1 -a $face3 = 2 ]
	then
		((coin["HTH"]++))

	elif [ $face1 -eq 1 -a $face2 -eq 2 -a $face3 -eq 2 ]
	then
		((coin["THH"]++))

	elif [ $face1 -eq 1 -a $face2 -eq 1 -a $face3 -eq 2 ]
	then
		((coin["TTH"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 2 -a $face3 = 2 ]
        then
                ((coin["HHH"]++))

	elif [ $face1 -eq 1 -a $face2 -eq 2 -a $face3 = 1 ]
        then
                ((coin["THT"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 1 -a $face3 = 1 ]
        then
                ((coin["HTT"]++))

	elif [ $face1 -eq 2 -a $face2 -eq 2 -a $face3 = 1 ]
        then
                ((coin["HHT"]++))
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


#Using subshell to run the function and show the number of times each combination showed up
for key in ${!coin[@]}
do
	coinStat["$key"]="${coin["$key"]} times $(facePercent ${coin["$key"]} $times)%"

	echo "$key came ${coinStat["$key"]}"
done

