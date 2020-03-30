#!/bin/bash
#Author: Samson
#Description : Using SED to remove a column from 
#text file, before displaying in terminal
#First sed change empty space to comma
#second sed replace rec with 'name'
#third sed replace the value as height
#fouth sed replace the value as width
#fifth sed remove the fouth column
#sixth sed replace the value as width
sed -e 's/ /,/g' rectangle.txt | sed -e 's/Rec/Name: Rec/g' | sed -e 's/,/ Height: /' | sed -e 's/,/ Width: /' | sed -e 's/,[^,]*/ /' | sed -e 's/,/Colour: /'
