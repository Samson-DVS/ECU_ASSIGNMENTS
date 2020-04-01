#!/bin/bash
#Author: Samson
#Description : Using SED to remove a column from 
#text file, before displaying in terminal
#Sed 1 change empty space to comma
#Sed 2 replace rec with 'name'
#Sed 3 replace the value as height
#Sed 4 replace the value as width
#Sed 5 remove the fouth column
#Sed 6 replace the value as width
sed -e 's/ /,/g' rectangle.txt | sed -e 's/Rec/Name: Rec/g' | sed -e 's/,/ Height: /' | sed -e 's/,/ Width: /' | sed -e 's/,[^,]*/ /' | sed -e 's/,/Colour: /'
