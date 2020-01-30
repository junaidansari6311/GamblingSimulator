#!/bin/bash
echo "WELCOME TO GAMBLING SIMULATOR"
#dictionary
declare -A wonOrLostAmountPerDay
declare -A winningOrLoosing
#constants
BET=1
STAKE=100
PERCENTAGE=50
WINNING_LIMIT=$(($(($PERCENTAGE*$STAKE/100)) + $STAKE))
LOOSING_LIMIT=$(($STAKE - $(($PERCENTAGE*$STAKE/100))))
NO_OF_DAYS=20
#variables
cashInHand=$STAKE
winningAmount=0
loosingAmount=0
wonCount=0
lostCount=0
presentAmount=0

function bets () {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		cashInHand=$(($cashInHand + $BET))
	else
		cashInHand=$(($cashInHand - $BET))
	fi
}
function winningOrLoosingPerDay () {
	if [ $cashInHand -ge $WINNING_LIMIT ]
	then
		winningAmount=$(($winningAmount+50))
		presentAmount=$(($presentAmount + 50))
		cashInHand=$STAKE
		winningOrLoosing[$1]="won"
		((wonCount++))
	else
		loosingAmount=$(($loosingAmount+50))
		presentAmount=$(($presentAmount - 50))
		cashInHand=$STAKE
		winningOrLoosing[$1]="lost"
		((lostCount++))
	fi
}
function amountWonOrLostIn20Days () {
	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "You won by $(($winningAmount - $loosingAmount)) in 20 days" 
	elif [ $loosingAmount -gt $winningAmount ]
	then
		echo "You lost by $(($loosingAmount - $winningAmount)) in 20 days"
	else
		echo "You neither won nor lost "
	fi
}
function gamble() {
	for ((i=1;i<=$NO_OF_DAYS; i++))
	do
		while [[ $cashInHand -lt $WINNING_LIMIT && $cashInHand -gt $LOOSING_LIMIT ]]
		do
			bets
		done
		winningOrLoosingPerDay $i
		wonOrLostAmountPerDay[$i]=$presentAmount
	done
	amountWonOrLostIn20Days
	echo "No of days won : $wonCount"
	echo "No of days lost  : $lostCount"
	echo "Amount won : $winningAmount"
	echo "Amount lost : $loosingAmount"

	echo "KEYS          :  ${!wonOrLostAmountPerDay[@]}"
	echo "AMOUNT per DAY: ${wonOrLostAmountPerDay[@]}"
	echo "KEYS        : ${!winningOrLoosing[@]}"
	echo "WON OR LOST : ${winningOrLoosing[@]}"
}
function checkLuckiestAndUnlucliestDay () {
	for i in ${!wonOrLostAmountPerDay[@]}
	do
		echo "$i ${wonOrLostAmountPerDay[$i]}"
	done | sort -k2 $1 | head -1
}
while [[ presentAmount -ge 0 ]]
do
	gamble
	echo "Luckiest day and Amount"
	checkLuckiestAndUnlucliestDay -rn
	echo "Unluckiest day and Amount"
	checkLuckiestAndUnlucliestDay -n
	differenceOfAmountWonOrLost=$(($(($wonCount*$PERCENTAGE)) - $(($lostCount*$PERCENTAGE))))
	if [ $differenceOfAmountWonOrLost -ge 0 ]
	then
		read -p "Do you want to continue next month? (y/n) " answer
		if [ $answer == "y" ]
		then
			echo "--------------------Next Month----------------------------"
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
