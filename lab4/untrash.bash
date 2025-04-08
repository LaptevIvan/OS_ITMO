#!/bin/bash

read -r givenFile <<< "$2"

key="$1"
if [[ "$key" == "-i" || "$key" == "--ignore" ]]
then
	key=i
elif [[ "$key" == "-u" || "$key" == "--unique" ]]
then	
	key=u 
	declare -A replays
elif [[ "$key" == "-o" || "$key" == "--overwrite" ]]
then	
	key=o 
else
	givenFile="$key"
	key=i
fi

if [[ -z "$givenFile" ]]
then
	echo "You have not inputted name of file"
	exit
fi	

fileSearch=$HOME/.trash.log
dirSearch=$HOME/.trash

if [[ ! (-e $fileSearch && -e $dirSearch) ]]
then 
	echo "For the correct environment, run the rmtrash script first"
	exit
fi

files=$(grep -P "/\Q$givenFile\E-\d+\$" $fileSearch) 
IFS=$'\n'
for file in $files 
do
	pathName="${file%-*}"
	path="${pathName%/*}"
	name="${pathName##*/}"
	n="${file##*-}"

	if [[ ! -e "$dirSearch/$n" ]]
	then
		continue
	fi	

	echo "Do you want to recover this file [Yes - y, no - else]: $pathName"
	read response
	if [[ "$response" != "y" ]]
	then
		continue
	fi	

	if [[ ! -e "$path" ]]
	then
		if [[ -z "$msg" ]]
		then
			echo -e "There is no directory where this file was.\nNow target directory is your home directory."
			if [[ $key == u ]]
			then 	
				unset replays
				declare -A replays
			fi
			msg="no" 
		fi	
		path="$HOME"
		pathName="$path/$name"
	fi

	case $key in 
	u)
		nmFinal="$name"
		if [[ -e "$pathName" ]]
		then
			let cntRep=${replays["$name"]}+1
			nm="${name%.*}"
		 	format="${name##*.}"
		 	if [[ "$format" == "$nm" ]]
		 	then
		 		format=""
		 	else
		 		format=".$format"	
		 	fi
		 	nmFinal="$nm($cntRep)$format"
		 	while [[ -e "$path/$nmFinal" ]] # In biggest part of cases this cycle will make 0 iterations.
		 	do				# I wrote its for the case when file "$nm($cntRep)$format"  	
		 		((cntRep++))		# already exists in target directory (for example, user added its before start of this script)
		 		nmFinal="$nm($cntRep)$format"
		 	done
		 	let replays['$name']=$cntRep
		 	echo "Due to a name conflict, the recovered file is now named: $nmFinal"
		 fi	
		 ln "$dirSearch/$n" "$path/$nmFinal" 
		 rm "$dirSearch/$n"
		;;
	  *)
		if [[ $key == "o" ]]
		then 
			flag=-f	
		elif [[ $key == "i" && -e "$pathName" ]]
		then
			echo "There is already a file with this name in target directory"
			continue	
		fi
		ln $flag "$dirSearch/$n" "$pathName" 
		rm "$dirSearch/$n"
	esac			 
done

