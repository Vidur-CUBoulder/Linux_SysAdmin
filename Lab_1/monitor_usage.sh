#!/bin/bash

# 1. Bash script to monitor the / and /boot directories
# 2. Send a mail to the admin if Use% is greater than the threshold supplied 
#    by the user from the command line.

#Store the parsed percentage values in the below variables
monitor_root=`df -ah / | awk '{print $5}' | cut -d \% -f 1 | awk 'FNR==2'`
monitor_boot=`df -ah /boot/ | awk '{print $5}' | cut -d \% -f 1 | awk 'FNR==2'`

#Hold the command line input from the user
THRESHOLD=$1
EMAIL="vidur.sarin@colorado.edu"

#Check if the value entered for percentage is > 100
if [ $THRESHOLD -gt 100 ]
then
	echo "Please enter a value lesser than 100"
	exit 1
#Check if there is no input from the command line
elif [ $# -eq 0 ]
then
	echo "No arguments supplied"
	exit 1
fi

#Send the mail if either value is greater than the entered threshold
if [ $monitor_boot -gt $THRESHOLD ]
then
	#Send the mail
	mail -s "FILESYSTEM THRESHOLD CROSSED!!" $EMAIL <<< "The Use% for /boot ($monitor_boot) has been exceeded!" 
fi

if [ $monitor_root -gt $THRESHOLD ]
then
	#Send the mail
	mail -s "FILESYSTEM THRESHOLD CROSSED!!" $EMAIL <<< "The Use% for / ($monitor_boot) has been exceeded!" 
fi