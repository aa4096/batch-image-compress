#!/bin/bash

# Author: Aaron Pena (@aa2048)
# Description: Bash script for batch compression of image files.
# Version: 2

# Set default filepath
FILEPATH="output"
resizedFile="1280x"
compressedFileSize=50k

# Icons and Formatting
CHECKMARK="\033[0;32m\xE2\x9C\x94\033[0m"
UNDERLINE=`tput smul`

# Set index to zero
i=0

while getopts ds:q:o:h option
	do
		case "${option}"
			in
				d) FILEPATH=${OPTARG};;
				s) resizedFile=${OPTARG};;
				q) compressedFileSize=${OPTARG};;
				o) i=${OPTARG};;
		esac
done

echo -e "\n${UNDERLINE}Initiating"

# Copy files to output directory
for file in *jpg
	do
		echo -ne ""
		# echo -ne "Copying \"${file}\" to Output Directory\r"
		mkdir -p "${FILEPATH}"
		cp "${file}" "${FILEPATH}"
		sleep .05
done

echo -ne "${CHECKMARK} Copying\n"

cd output

# Resize File
for file in *.jpg
	do 
		# echo -ne "Resizing: ${file}\r"
		convert "${file}" -resize $resizedFile "${file}"
		sleep .05
done

echo -ne "${CHECKMARK} Resizing\n"

# Compress File to filesize
for file in *.jpg
	do
		echo -ne ""
		# echo -ne "Compressing: ${file}\r"
		convert "${file}" -define jpeg:extent=${compressedFileSize}b "${file}"
		sleep .05
done

echo -ne "${CHECKMARK} Compressing\n"

DIRECTORY=$(pwd)
# nautilus . -w 2>/dev/null

workComplete="Image Conversion Complete!"
# spd-say --volume -85 "${workComplete}"
echo -ne "\n${workComplete}\n\a"
echo "View Output Directory: FILE://${DIRECTORY}"