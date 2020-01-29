#!/bin/bash
echo "WELCOME TO GAMBLING SIMULATOR"
#dictionary
declare -A wonOrLostPerDay
#constants
BET=1
WINNING_LIMIT=150
LOOSING_LIMIT=50
NO_OF_DAYS=20
#variables
stake=100
winningAmount=0
loosingAmount=0
wonCount=0
lostCount=0
presentAmount=0

function gamble() {
	for ((i=1;i<=$NO_OF_DAYS; i++))
	do
		while [[ $stake -lt $WINNING_LIMIT && $stake -gt $LOOSING_LIMIT ]]
		do
			if [ $((RANDOM%2)) -eq 1 ]
			then
				stake=$(($stake + $BET))
			else
				stake=$(($stake - $BET))
			fi
		done

		if [ $stake -ge $WINNING_LIMIT ]
		then
			winningAmount=$(($winningAmount+50))
			presentAmount=$(($presentAmount + 50))
			stake=100
			((wonCount++))
		else
			loosingAmount=$(($loosingAmount+50))
			presentAmount=$(($presentAmount - 50))
			stake=100
			((lostCount++))
		fi
		wonOrLostPerDay[$i]=$presentAmount
	done
	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "You won by $(($winningAmount - $loosingAmount)) in 20 days" 
	elif [ $loosingAmount -gt $winningAmount ]
	then
		echo "You lost by $(($loosingAmount - $winningAmount)) in 20 days"
	else
		echo "You neither won nor lost "
	fi

	echo "No of days won : $wonCount"
	echo "No of days lost  : $lostCount"
	echo "Amount won : $winningAmount"
	echo "Amount lost : $loosingAmount"

	echo ${!wonOrLostPerDay[@]}
	echo ${wonOrLostPerDay[@]}
}
function checkLuckiestAndUnlucliestDay () {
	for i in ${!wonOrLostPerDay[@]}
	do
		echo "$i ${wonOrLostPerDay[$i]}"
	done | sort -k2 $1 | head -1
}
while [[ presentAmount -ge 0 ]]
do
	gamble
	echo "Luckiest day"
	checkLuckiestAndUnlucliestDay -rn
	echo "Unluckiest day"
	checkLuckiestAndUnlucliestDay -n
	if [ ${wonOrLostPerDay[20]} -ge 0 ]
	then
		read -p "Do you want to continue next month? (y/n) " answer
		if [ answer=="y" ]
		then
			winningAmount=0
			loosingAmount=0
			wonCount=0
			lostCount=0
			presentAmount=0
		else
			break
		fi
	fi
done
