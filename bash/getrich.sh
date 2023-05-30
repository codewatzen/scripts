#!/bin/bash
# A bash script that I took from a NetworkChuck tutorial https://www.youtube.com/watch?v=19nN9vgcgmU
echo "What is your name?"
read -r name
echo "How old are you?"
read -r age
echo "Hello $name, you are $age years old. Let's find out when you will be a millionaire."
echo "Calcalating when you will become rich."
echo "......."
echo "*......"
echo "**....."
echo "*****.."
echo "*******"
numRan=$((RANDOM % 15))
richAge=$((numRan + age))
ageDif=$((richAge - age))
echo "$name, you will be a millionaire at the age of $richAge. That is $ageDif years away."
#blank commment