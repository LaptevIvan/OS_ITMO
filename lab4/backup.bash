#!/bin/bash

isDifferentSize() {
    file1="$1"
    file2="$2"
    
    size1=$(stat -c %s "$file1")
    size2=$(stat -c %s "$file2")
    
    if [[ $size1 -eq $size2 ]]
    then
        return 1
    fi   
    return 0
}

writeStringInFile() {
    prefix=$1
    fl="$2"
    str=$3
    if [[ -n $str ]]
    then
        echo -e "$prefix$str" >> "$fl"
    fi   
}

currentDate=$(date +%Y-%m-%d)
n=6
endDate=$(date -d "$currentDate $n days ago" +%Y-%m-%d)
lastBackup=$(find $HOME -maxdepth 1  -type d -regextype grep -regex ".*Backup-[[:digit:]]\{4\}-[[:digit:]]\{2\}-[[:digit:]]\{2\}$" | sort -r | head -n 1)
dateLastBackup=$(echo $lastBackup | cut -d '-' -f 2-)
if [[ -z $dateLastBackup || $dateLastBackup < $endDate  ]]
then
	backup="$HOME/Backup-$currentDate"
	newBck=1
	mkdir $backup
else 
	backup=$lastBackup 
	newBck=0
fi

if [[ $newBck -eq 1 ]]
then
	msg="New backup directory ($backup) has been created"
else 
	msg="backup directory ($backup) updated $currentDate"
fi 	

searchDir="$HOME/source"
reportFile="$HOME/backup-report"
touch $reportFile

echo $msg >> $reportFile
files=$(find $searchDir -type f)

while read -r file;
do
    name="${file##*/}"
    sameFileInBackup=$backup/$name
    if [[ ! -e "$sameFileInBackup" ]] 
    then
        new+="$name\n"
        cp "$file" "$backup"
  	elif isDifferentSize "$file" "$sameFileInBackup"
    then
        newName="$sameFileInBackup($currentDate)"
        mv "$sameFileInBackup" "$newName"
        newUpd+="$name $name($currentDate)\n"
        cp "$file" "$backup/$name"
    fi
done <<< "$files"

writeStringInFile "New files:\n" "$reportFile" "$new"
writeStringInFile "New versions of old files:\n" "$reportFile" "$newUpd" 

