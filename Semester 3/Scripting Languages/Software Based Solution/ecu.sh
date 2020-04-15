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

getimagerange()
{
    #start loop to check for errors
    while :; do
       
        read -p "Which image do you want to start download from? " begin
        read -p "Which image do you want to end download at? " end
        if (( $begin < 1533 || $begin > 2042 )); then
        echo "Enter a number between 1533 and 2042!!"
        elif (( $end < 1533 || $end > 2042 )); then
        echo "Enter a number between 1533 and 2042!!"
        elif [ $begin -gt $end ]; then
        echo "Minimum range must be greater then Maximumrange!"
        echo "Try Again!"
        else
        break
        fi
    done
    for i in $(seq $begin $end)
    do 
        local name=$i
        if ! wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$i.jpg; then
        echo "Trying to download DSCO$name..."
        echo "Error 404: File Not Found"
        else
        filesize=$(stat -c %s DSC0$name.jpg); 
        filesizekb=$(awk -v filesizekb=$filesize 'BEGIN { printf "%.2f\n", filesizekb / 1000 }')
        echo "Downloading DSC0$name, with the file name DSC0$name.jpg, with a file size of $filesizekb kb..." 
        echo -e "Download Complete\n"
        #move downloaded images into image dir
        fi

    done
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
        getimagerange ;;
    3)
        randquantity ;;
    4)
        allImageFile ;;
    *)
        echo "Invalid" ;;
esac
