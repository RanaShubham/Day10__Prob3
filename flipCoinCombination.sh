#!/bin/bash -x

echo "Welcome to flip Tcoin combination program"

read -p "Enter times you want to flip for each singlet doublet and triplet combinations: " times

declare -A Tcoin
declare -A Dcoin
declare -A Scoin

function facePercent ()
{
        local faceTimes=$1
        local total=$2

        per=`awk " BEGIN {print ($faceTimes/$total)*100 }"`
        echo "$per"
}

echo "_____________________________________________________________________________________"
counter=0

#Tails is 1 and heads is 2
Scoin["T"]=0
Scoin["H"]=0

while [[ $counter != $times ]]
do
	sFace=$((1+RANDOM%2))
	if [ $sFace = 1 ]
	then
		((Scoin["T"]++))
	else
		((Scoin["H"]++))
	fi

	((counter++))
done

for key in ${!Scoin[@]}
do
        ScoinStat["$key"]="${Scoin["$key"]} times $(facePercent ${Scoin["$key"]} $times)%"

        echo "$key came ${ScoinStat["$key"]}"
done

if [[ ${Scoin["T"]} -ge ${Scoin["H"]} ]]
then
	max=T
else
	max=H
fi

echo "$max won for singlets"

echo "______________________________________________________________________________________"

counter=0

Dcoin["TT"]=0
Dcoin["HH"]=0
Dcoin["HT"]=0
Dcoin["TH"]=0

while [[ $counter != $times ]]
do
	dFace1=$((1+RANDOM%2))
	dFace2=$((1+RANDOM%2))
	
	if [ $dFace1 = 1 -a $dFace2 = 1 ]
	then
		((Dcoin["TT"]++))

	elif [ $dFace1 = 2 -a $dFace2 = 2 ]
	then
		((Dcoin["HH"]++))
	elif [ $dFace1 = 2 -a $dFace2 = 1 ]
	then
		((Dcoin["HT"]++))

	elif [ $dFace1 = 1 -a $dFace2 = 2 ]
	then
		((Dcoin["TH"]++))
	fi

	((counter++))
done
for key in ${!Dcoin[@]}
do
        DcoinStat["$key"]="${Dcoin["$key"]} times $(facePercent ${Dcoin["$key"]} $times)%"

        echo "$key came ${DcoinStat["$key"]}"
done

max="HH"
for key in ${!Dcoin[@]}
do
        if [[ ${Dcoin["$key"]} -ge ${Dcoin["$max"]} ]]
        then
                max=$key
        fi
done

echo "$max combination won for doublets"


echo "______________________________________________________________________________________"

counter=0

Tcoin["HHH"]=0
Tcoin["HTH"]=0
Tcoin["THH"]=0
Tcoin["TTH"]=0
Tcoin["TTT"]=0
Tcoin["THT"]=0
Tcoin["HTT"]=0
Tcoin["HHT"]=0


while [[ $counter != $times ]]
do
	tFace1=$((1+RANDOM%2))
	tFace2=$((1+RANDOM%2))
	tFace3=$((1+RANDOM%2))

	if [ $tFace1 -eq 1 -a $tFace2 -eq 1 -a $tFace3 = 1 ]
	then
		((Tcoin["TTT"]++))

	elif [ $tFace1 -eq 2 -a $tFace2 -eq 1 -a $tFace3 = 2 ]
	then
		((Tcoin["HTH"]++))

	elif [ $tFace1 -eq 1 -a $tFace2 -eq 2 -a $tFace3 -eq 2 ]
	then
		((Tcoin["THH"]++))

	elif [ $tFace1 -eq 1 -a $tFace2 -eq 1 -a $tFace3 -eq 2 ]
	then
		((Tcoin["TTH"]++))

	elif [ $tFace1 -eq 2 -a $tFace2 -eq 2 -a $tFace3 = 2 ]
        then
                ((Tcoin["HHH"]++))

	elif [ $tFace1 -eq 1 -a $tFace2 -eq 2 -a $tFace3 = 1 ]
        then
                ((Tcoin["THT"]++))

	elif [ $tFace1 -eq 2 -a $tFace2 -eq 1 -a $tFace3 = 1 ]
        then
                ((Tcoin["HTT"]++))

	elif [ $tFace1 -eq 2 -a $tFace2 -eq 2 -a $tFace3 = 1 ]
        then
                ((Tcoin["HHT"]++))
	fi

	((counter++))
done


#Using subshell to run the function and show the number of times each combination showed up
for key in ${!Tcoin[@]}
do
	TcoinStat["$key"]="${Tcoin["$key"]} times $(facePercent ${Tcoin["$key"]} $times)%"

	echo "$key came ${TcoinStat["$key"]}"
done

max="HHH"
for key in ${!Tcoin[@]}
do
        if [[ ${Tcoin["$key"]} -ge ${Tcoin["$max"]} ]]
        then
                max=$key
        fi
done

echo "$max combination won for triplets"

echo "_____________________________________________________________________________________"
