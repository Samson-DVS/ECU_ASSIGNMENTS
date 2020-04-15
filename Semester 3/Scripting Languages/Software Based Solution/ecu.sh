#!/bin/bash
function author () {
echo -e "Student name : Visahl Samson David Selvam"
echo -e "Student id   : 10498743"
}


file_path="Samson"


function manual () {
#Explains the functionality of the program
echo -e "-----------Please follow the instructions about the program----------------------"

echo -e "->->-> To download specific thumbnail please enter 1  ->->->"                            
echo -e "->->-> To download range of thumbnails please enter 2 ->->->"
echo -e "->->-> To download random thumbnails please enter 3   ->->->"
echo -e "->->-> To download all  thumbnails please enter 4     ->->->"

echo -e "-------------------------------------------------------------------------------"

read -p "Enter your choice: " choice 
}
author
manual

[[ -e ecuimagesimages.txt ]] || [[ -s ecuimages.txt ]] || curl https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 | grep -o -e 'http[^"]*\.jpg' > ecuimages.txt | sort -u ecuimages.txt

singleImageFile()
{
    read -p "Please enter last 4 digitis of the file : DSC0 " digit
	if grep  "DSC0$digit" ecuimages.txt
	then
    wget - https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$digit.jpg -P $file_path
	echo -e "$----------------PROGRAM FINISHED-----------------"
	else
	echo -e "The image file does not exist please check the name you entered"
	fi
}
range()
{
    read -p "Please enter last 4 digitis of the file start range: " begin
    read -p "Please enter last 4 digitis of the file end range: " end
    if [[ $begin < $end ]]; then
    wget https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$begin.jpg -P $file_path
    let begin+=1
	let end+=1
   	echo -e "----------------PROGRAM FINISHED-----------------"
	else
	echo -e "The start range should be less than the end range"
	fi
}
maxi=75

randquantity()
{
    
	read -p "Number of image to Download: " quantity
	if [ $quantity -gt $maxi ]; then
            echo "Maximum number of images is $maxi"
	elif [[ $quantity =~ ^[0-9]+$ ]]; then
	shuf -n $quantity ecuimages.txt > selected.txt
    wget -i selected.txt -P $file_path
	echo -e "----------------PROGRAM FINISHED-----------------"
	else
			echo -e "Input is invalid character. Please enter a positive integer only!"
	fi 
}
allImageFile()
{
    wget -i ecuimages.txt -P $file_path
}

case $choice in
    1)
        singleImageFile ;;
    2)
        range ;;
    3)
        randquantity ;;
    4)
        allImageFile ;;
    *)
        echo "Invalid" ;;
esac
