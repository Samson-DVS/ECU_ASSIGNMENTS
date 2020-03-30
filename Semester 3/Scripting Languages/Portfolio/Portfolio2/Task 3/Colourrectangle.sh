#!/bin/bash
#Author : Samson
#Description : Too list the rectangles that has width more than 100 and red in colour
#Grep 1 to make the format
#Grep 2 to look for colour red
#Grep 3 to look for width more than 100
grep -E ",[0-9][0-9][0-9]" colourrectangle.txt | grep -i "Red" | grep -v "100"
