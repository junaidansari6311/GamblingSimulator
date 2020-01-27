#!/bin/bash -x
echo "WELCOME TO GAMBLING SIMULATOR" 
#constants
BET=1
WINNING_LIMIT=150
LOOSING_LIMIT=50
NO_OF_DAYS=20
#variables
stake=100
winningAmount=0
loosingAmount=0
WonCount=0
LostCount=0
for ((i=1;i<=$NO_OF_DAYS;i++))
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
		stake=100
		((wonCount++))
	else
		loosingAmount=$(($loosingAmount+50))
		stake=100
		((lostCount++))
	fi
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
echo "Amount won : $(($wonCount*50))"
echo "Amount lost : $(($lostCount*50))"
