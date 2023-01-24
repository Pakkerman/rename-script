#! /bin/bash
### This script is aimed to make rename file in a single click
### Script will take a directory and name all files inside in order from 0000 to 9999

### run "chmod +x rename.sh" first in bash, to give permission to run script

path=$(osascript -e 'POSIX path of (choose folder with prompt "Choose a folder:")')
if [ $? -ne 0 ]; then
  echo "The user canceled the dialog or the script returned an empty value."
  exit 1
fi

read -p "Rename files in $path? (y/n)" CONFIRM
case "$CONFIRM" in
  [yY] | [yY][eE][sS] | "" ) echo "Continuing" ;;
  [nN] | [nN][oO]) echo "Canceled" ; exit ;;
  *) echo "Invalid input."; exit ;;
esac

cd $path
read -p "Set prefix (press enter to use folder as the prefix):  " PREFIX
case "$PREFIX" in
  "") FILEPREFIX=${PWD##*/}- ;;
  *) FILEPREFIX="$PREFIX-" ;;
  *) 
esac
  echo "Using $FILEPREFIX as prefix..." 


FILES=$(ls $path -p | grep -v /)

COUNTER=1
for FILE in $FILES
  do
    FILENAME=$(printf "%04d\n" $COUNTER)
    EXTENSION="${FILE##*.}"
    echo "$FILE >>> $FILEPREFIX$FILENAME.$EXTENSION"
    mv -f $path$FILE $path$FILEPREFIX$FILENAME.$EXTENSION

    ((COUNTER++))
done

echo "Finished"




