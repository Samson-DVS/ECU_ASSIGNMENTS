#!/bin/bash
# Author : Samson
# Discription : Registration form
# Color Assigning 
Red='\033[31m'
Yellow='\033[1;33m'
Green='\033[32m'

# Collecting User input and stroing them in Variables 
echo Task 3 Registration Form
read -p "Please enter your Name : " NAME
read -p "Please enter your Date Of Birth : " DOB
read -p "Please enter your Address : " ADDRESS
echo choose your option 1. Red 2.Yellow 3. Green
read -p "Please enter your Desired Color (1/2/3): " COLOR
# checking the condition and execute
# and display user details 
if [ "$COLOR" = "1" ]; then
 echo -e "${Red}Your Name is $NAME"
 echo -e "${Red}$NAME's Date Of Birth = $DOB"
 echo -e "${Red}$NAME's Address = $ADDRESS"
 echo -e "${Red}$NAME's Desired Color = Red"
elif [ "$COLOR" = "2" ]; then
 echo -e "${Yellow}Your Name = $NAME"
 echo -e "${Yellow}$NAME's Date Of Birth = $DOB"
 echo -e "${Yellow}$NAME's Address = $ADDRESS"
 echo -e "${Yellow}$NAME's Desired Color = Yellow"
elif [ "$COLOR" = "3" ]; then
 echo -e "${Green}Your Name is $NAME"
 echo -e "${Green}$NAME's Date Of Birth = $DOB"
 echo -e "${Green}$NAME's Address = $ADDRESS"
 echo -e "${Green}$NAME's Desired Color = Green"
fi
exit 0

