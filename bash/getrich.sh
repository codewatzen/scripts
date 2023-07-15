#!/bin/bash
# A bash script that I took from a NetworkChuck tutorial https://www.youtube.com/watch?v=19nN9vgcgmU

# Prompt the user for their name
read -rp "What is your name? " name

# Prompt the user for their age
read -rp "How old are you? " age

# Greet the user and provide information about their age
echo "Hello $name, you are $age years old. Let's find out when you will be a millionaire."

# Perform the calculation to determine the age at which the user will become a millionaire
echo "Calculating when you will become rich."
sleep 1
echo "..."
sleep 1
echo "*.."
sleep 1
echo "**."
sleep 1
echo "****"
sleep 1
echo "*******"

# Generate a random number to add to the current age
numRan=$((RANDOM % 15))
richAge=$((numRan + age))
ageDif=$((richAge - age))

# Display the result to the user
echo "$name, you will be a millionaire at the age of $richAge. That is $ageDif years away."
