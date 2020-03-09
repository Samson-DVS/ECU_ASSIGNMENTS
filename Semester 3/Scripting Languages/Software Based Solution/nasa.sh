#!/bin/bash
#Author: Samson
#Description : To download images from nasa website


function guide() {
		echo "*************************Script Usage*************************************"
		echo "Example of the commands for each of the inputs are,"
		echo "To Download Single Image; i.e. ./nasa.sh -d 2020-03-06"
		echo "To see explanation; i.e. ./nasa.sh --type 2020-03-06" 
		echo "To see details; i.e. ./nasa.sh -t 2020-03-06"
		echo "To download multiple images; i.e. ./nasa.sh --range 2020-03-02 2020-03-06"
		echo "**************************************************************************"
    }

function content_storage() {
    local formatDate=$(date -d $@ +%y%m%d)
    local url="https://apod.nasa.gov/apod/ap"$(echo "$formatDate")".html"
    local content=$(curl -s $url)
    if [[ $? -eq 0 ]]; then
        echo "$content"
    else
        echo "Content not found"
    fi
}
function get_image_name_and_title() {
    local imageName=$(echo $@ | grep -o "<b>.*</b> <br>" | sed 's/<[^>]*>//g')
    echo $imageName
}
function get_explanation() {
    local explain=$(echo $@ | grep -o "<b> Explanation.*<p>.*<center>" | sed 's/<[^>]*>//g')
    echo $explain
}
function get_image_credit() {
    local credit=$(echo $@ | grep -o "Image Credit.*</center> <p>" | sed 's/<[^>]*>//g')
    echo $credit
}
function get_image_link() {
    local extension=$(echo $@ | grep -o 'image/.*<I' | sed 's/<I/>/g' | tr -d '>"')
    local addExtension="https://apod.nasa.gov/apod/"$extension
    if [ -z $extension ]; then
        echo "Image Not Found"
    else
        echo $addExtension
    fi
}
function download_image() {
    htmlContent=$(content_storage $@)
    if [[ $htmlContent = "notFound" ]]; then
        echo -e "\nCannot connect to nasa.gov. site"
        exit 1
    else
        imageLink=$(get_image_link $htmlContent)
        if [[ $imageLink = "noImageFound" ]]; then
            echo -e "\nNo image was found for this date."
            exit 1
        else
            imageName=$(get_image_name_and_title $htmlContent)
            imageType=$(get_image_link $htmlContent | sed 's/.*\.//')
            echo -e "\nDownloading "\"${imageName}"."${imageType}\"
            wget -q $imageLink
        fi
    fi
}
function view_explanation() {
    htmlContent=$(content_storage $@)
    if [[ $htmlContent = "notFound" ]]; then
        echo -e "\nUnable to connect to nasa.gov."
        exit 1
    else
        explain=$(get_explanation $htmlContent | sed 's/\<Explanation\>://g')
        if [[ -z $explain ]]; then
            echo -e "\nNo image available for the specified date.."
            exit 1
        else
            echo -e "\n$Explanation"
        fi
    fi
}
function view_detail() {
    htmlContent=$(content_storage $@)
    if [[ $htmlContent = "notFound" ]]; then
        echo -e "\nUnable to connect to nasa.gov."
        exit 1
    else
        title=$(get_image_name_and_title $htmlContent)
        echo -e "\nTITLE: $title"
        explain=$(get_explanation $htmlContent | sed 's/Explanation/EXPLANATION/')
        echo -e "\n$explain"
        credit=$(get_image_credit $htmlContent | sed 's/Image Credit/IMAGE CREDIT/')
        if [[ -z $credit ]]; then
            echo -e "\nNo image available today. Please try again later.."
            exit 1
        else
            echo -e "\n$credit"
        fi
    fi
}
function download_imageRange() {
    i=1
    startDate=$(date -d $1 +%y%m%d)
    endDate=$(date -d $2 +%y%m%d)
    between=$(($endDate-$startDate))
    if [[ $between -le 10 ]]; then
        rangeDate=$startDate
        while [ "$rangeDate" -le "$endDate" ]; do
            callDownloadImg=$(download_image "$rangeDate")
            echo "$callDownloadImg"
            rangeDate=$(date +%y%m%d -d "$rangeDate + i day")
            i=i++;
        done
    else 
        echo -e "\nMaximum number of images to download is 10. Please try again."
    fi
}
case $1 in
    "-d")
        guide
	echo -e "Connecting to nasa.gov..."
        download_image $2
        echo -e "\nFinished.";;
    "--type")
        guide
	echo -e "Connecting to nasa.gov..."
        view_explanation $2
        echo -e "\nFinished.";;
    "-t")
        guide
	echo -e "Connecting to nasa.gov..."
        view_detail $2
        echo -e "\nFinished.";;
    "--range")
        guide
	echo -e "Connecting to nasa.gov..."
        download_imageRange $2 $3
        echo -e "\nFinished.";;
    *)
	guide
        echo -e "\nInvalid input detected. Please follow the instructions.";;
esac
exit 0
