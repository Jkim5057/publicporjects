#!/bin/bash

#Simple text UI based file transfer from the command line

echo "what is the file name?"
read FILE

if [ -e "$FILE" ]; then
	echo "it exists."

	echo "enter C to copy the file, M to move the file, and D to delete the file."

	read ACTION

case $ACTION in
C) 
 echo "Where would you like it copied? Must be a valid path!"
read PATH

 (/bin/cp  $FILE $PATH ) ;;

M) 

 echo "Where would you like it moved? Must be a valid path!"
read PATH

 (/bin/mv  $FILE $PATH ) ;;

D) 
 (/bin/rm $FILE)

echo "$FILE has been removed" ;;

*)

echo "That was not one of the options!" ;;

esac

else

echo "file does not exist" 
fi



