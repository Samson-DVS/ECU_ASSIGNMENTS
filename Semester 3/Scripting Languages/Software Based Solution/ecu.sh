#!/bin/bash
#Student Details
function author () {
echo -e "---------------------Student Details---------------------"
echo -e "|      Student name : Visahl Samson David Selvam        |"
echo -e "|      Student Id   : 10498743       				               |"
echo -e "---------------------------------------------------------"
}

#path to store the downloaded images
mkdir -p Samson
file_path="Samson"

#since curl is not default part of the linux distributions
#this will ask the user for the root password
#if curl isn't installed then it will install
#if already installed it will continue
sudo apt install curl

#move the images to directory samson
move () {
mv *.jpg ./$file_path
}

function manual () {
#Explains the functionality of the program
echo -e "-----------Instructions about the program----------"

echo -e "| To download single thumbnail please enter    1  |"                            
echo -e "| To download range of thumbnails please enter 2  |"
echo -e "| To download random thumbnails please enter   3  |"
echo -e "| To download all  thumbnails please enter     4  |"
echo -e "| To quit please enter                         q  |"

echo -e "---------------------------------------------------"

#collecting input from user
read -p "Enter your choice: " choice 
}

#executing the author and manual functions
author
manual


#storing the URL in text file named ecuimages.txt
#Also using grep to eliminate the other web elements other than URLS
#then passing only numbers to imagenumbers.txt file 
[[ -e ecuimagesimages.txt ]] || [[ -s ecuimages.txt ]] || curl https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152 | grep -o -e 'http[^"]*\.jpg' > ecuimages.txt | sort -u ecuimages.txt
cp ecuimages.txt imagenumbers.txt
sed -i 's/.*\/D/D/g; s/.jpg//g' imagenumbers.txt


#function to download single image
singleImageFile()
{
    while :; do
       #collecting input from user. 
	   #the user has to enter only last 4 digits of the file
	   read -p "Please enter last 4 digitis of the file : DSC0 " digit
        #if the number only between 1533 and 2042 then the program continues
        if (( $digit >= 1533 && $digit <= 2042 )); then
        break
        else 
        echo "The number shoud be  between 1533 and 2042"
        fi
    done
	#downloading image and savind them in the desi{Red} path
    if ! wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$digit.jpg; then
         echo "File Not Found please check the name ente{Red}"
    else
	#caluting the file size
    size_of_file=$(stat -c %s DSC0$digit.jpg); 
	#converting the file size to KB
    size_of_filekb=$(awk -v size_of_filekb=$size_of_file 'BEGIN { printf "%.2f\n", size_of_filekb / 1000 }')
    echo "Downloading DSC0$digit, with the file name DSC0$digit.jpg, with a file size of $size_of_filekb kb..." 
    echo "Download Complete"
    echo "----------------PROGRAM FINISHED-----------------"
    mv DSC0$digit.jpg ./$file_path    
fi
}

#function to download range of images
getimagerange()
{
    while :; do
        #Collecting input from the user  
	    read -p "Enter the start range: " begin
        read -p "Enter the end range " end
		#Chekcing the range values against available values
        if (( $begin < 1533 || $begin > 2042 )); then
        echo "The number should be between 1533 and 2042"
        elif (( $end < 1533 || $end > 2042 )); then
        echo "The number should be between 1533 and 2042"
        elif [ $begin -gt $end ]; then
		#Alert message if the values are not satisfying
        echo "Start range must be greater then End!"
        echo "Please try again!"
        else
        break
        fi
    done
	#Saving the ranges in sinlge variable i
    for i in $(seq $begin $end)
    do 
        local name=$i
        if ! wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$i.jpg; then
        echo "Trying to download DSCO$name..."
        echo "No file found"
        else
		#caluting the file size
        size_of_file=$(stat -c %s DSC0$name.jpg); 	
		#converting the file size to KB
        size_of_filekb=$(awk -v size_of_filekb=$size_of_file 'BEGIN { printf "%.2f\n", size_of_filekb / 1000 }')
        echo "Downloading DSC0$name, with the file name DSC0$name.jpg, with a file size of $size_of_filekb kb..." 
        echo -e "----------------PROGRAM FINISHED-----------------"
		move
fi

    done
}

limit=75
randquantity()
{
    
main ()
{
	times=0
	while [ $times != "$quantity" ]; do
    #shuffling the imagenumbers.txt file to pick random images
	local name=$(cat ./imagenumbers.txt | shuf -n 1)
	 wget -q https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$name.jpg 
 #caluting the file size
	size_of_file=$(stat -c %s "$name".jpg); 
    #converting the file size to KB
	size_of_filekb=$(awk -v size_of_filekb="$size_of_file" 'BEGIN { printf "%.2f\n", size_of_filekb / 1000 }')
    echo "Downloading $name, with the file name $name.jpg, with a file size of $size_of_filekb kb..." 
    echo -e "Download Complete\n"
	move
((times+=1))
	done
	echo "----------------PROGRAM FINISHED-----------------"
	
}

#using if statement to validate the input
	#collecting input from user
    read -p "Enter how many pictures to be downloaded: " quantity
	if [[ $quantity -gt $limit ]]; then
            echo "Maximum number of images is $limit"
	elif [[ ! $quantity =~ ^[0-9]+$ ]]; then
	echo -e "invalid character detected please enter only numeric value"
	else
	main
	fi
	
    
 }

allImageFile ()
{
    echo "Downloading all images..."
	#goign through all the linex of ecuimages.text file
    while read -r line; do
        wget -q $line 
	#readint the 60th character of each line 
	#upto 8 character. Since, that would be the image names
	    local name=${line:60:8}
    #caluting the file size
		size_of_file=$(stat -c %s $name.jpg); 
    #converting the file size to KB
		size_of_filekb=$(awk -v size_of_filekb=$size_of_file 'BEGIN { printf "%.2f\n", size_of_filekb / 1000 }')
        echo "Downloading $name, with the file name $name.jpg, with a file size of $size_of_filekb kb..." 
        echo -e "Download Complete\n"
		move
    done < ecuimages.txt
    
echo "----------------PROGRAM FINISHED-----------------"
}

#functions that consists respected values accorind to the values
case $choice in
    1)
        singleImageFile ;;
    2)
        getimagerange ;;
    3)
        randquantity ;;
    4)
        allImageFile ;;
    q)
	    echo "Thanks for using this program"
	    exit 0 ;;
    *)
        echo "Invalid Choice" ;;
esac
