#!/bin/bash
#Author : Samson
#Discription :  A sample menu display, Bash script
#Displaying menu items to choose
echo   Welcome To Display Menu
echo ==========================
echo 1.Register User
echo 2.Users Details
echo 3.Edit User
echo 4.Save User  
echo 5.Change Password 
echo 6.Print Report
echo 7.Exit
echo "Enter Your choice as (Eg : ./Createmenu.sh 1)."
if [ -v $1 ]; then
exit
fi
echo ==========================

#color code Assigning
White='\033[1;37m'
Gray='\033[90m'
Magneta='\033[35m'
Yellow='\033[33m'
Blue='\033[34m'
Green='\033[32m'
Cyan='\033[36m'
Red='\033[31m'

case $1 in

        1)
            echo -e "${White}Hey You Are Registered";;
        2)
            echo -e "${Gray}Details has been saved";;
        3)
            echo -e "${Magneta}Edit Saved";;
        4)
            echo -e "${Yellow}User has been Saved";;
        5)
            echo -e "${Blue}Password has been changed";;
        6)
            echo -e "${Green}Report has been printed";;
        7)
            echo -e "${Cyan}Thank You";;
	*) 
	 echo -e "${Red}Invalid input detected please try again"

esac

