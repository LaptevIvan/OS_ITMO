#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )

file=$script_dir/1_datetime.bash


new_entry="*/5 * * * 4 $file"
current_entries=$(crontab -l)  
IFS=$'\n' 

read -rd '' -a entries <<< "$current_entries"

if [[ ! "${entries[@]}" =~ .*"$new_entry".* ]];
then
        new_array=("${entries[@]}" "${new_entry}")
        printf '%s\n' "${new_array[@]}" | crontab  
fi


