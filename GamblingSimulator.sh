#!/bin/bash -x
echo "WELCOME TO GAMBLING SIMULATOR" 
#constants
BET=1
WINNING_LIMIT=150
LOOSING_LIMIT=50
#variables
stake=100
while [[ $stake -lt WINNING_LIMIT && $stake -gt LOOSING_LIMIT ]]
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
	echo "Gambler won and resigned for the day"
else
	echo "Gambler lost and resigned for the day"
fi
