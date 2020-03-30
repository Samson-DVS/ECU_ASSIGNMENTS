#!/bin/bash
#Author : Samson
#Discription : Script for age guessing game

#Displaying game brief to users
reception()
{
	echo "**********************************************"
    echo "This is a age guessing game"
    echo "Guess the age that has been generated!!!! "
    echo "Hint : Guess is between 20 to 70 Years"
	echo "**********************************************"
}

#Generating a random number between 20 to 70
random_generation()
{
    (( answer = 20 + RANDOM % 70 ))
}

#Function to play the game
game_play()
{
    while (( guess != answer )); do
        read -p "Enter your guess: " guess
        if (( guess < answer )); then
            echo "Your predicted answer is low"
            echo "Please try once again"
        elif (( guess > answer )); then
            echo " Your predicted answer is high"
            echo " Please try once again"
        fi
    done
    echo -e "Your guess is correct! Congrats"
}

reception
random_generation
game_play
