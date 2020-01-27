#!/bin/bash -x
echo "WELCOME TO GAMBLING SIMULATOR" 
#constants
BET=1
#variables
stake=100

if [ $((RANDOM%2)) -eq 1 ]
then
	stake=$(($stake + $BET))
else
	stake=$(($stake - $BET))
fi
