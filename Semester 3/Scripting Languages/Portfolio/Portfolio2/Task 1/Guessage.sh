#!/bin/bash
#Author : Samson
#Discription : Script for age guessing game

#Displaying game brief to users
reception()
{

	echo
	echo "-----------------------------------------------"
	echo "This is a age guessing game"
    echo "Guess the age that has been generated!!!! "
    echo "Hint : Guess is between 20 to 70 Years"
	echo "-----------------------------------------------"
	echo
}


#Random Generator Function
function random_generation() {
    ((diff=maxi-mini+1))
    local number_generated="$((mini + $RANDOM%diff))"
    echo "$number_generated"
}

#Using Regex to validate user input
regex='^[0-9]+$'

#Generate a number between min and max (20 and 70)
mini=20
maxi=70
number_generated="$(random_generation)"

#using while loop 
while true
    do
	reception
    read -p "Enter a value between $mini - $maxi: " user_input
    if ! [[ $user_input =~ $regex ]] ; then
    echo "Invalid Characters Detected" >&1;
    else
        if [ $user_input -lt $mini ]; then
            echo "Your guess is less than $mini"
        elif [ $user_input -gt $maxi ]; then
            echo "Your guess is more than $maxi"
        else
            if [ $user_input -gt $number_generated ]; then
                 echo " Your predicted answer is high"
				 echo "Please try once again"
			elif [ $user_input -lt $number_generated ]; then
                echo "Your predicted answer is low"
				echo "Please try once again"
			elif [ $user_input -eq $number_generated ]; then
                echo "Your guess is correct! Congrats"
                exit 0
            fi
        fi
    fi
    done
