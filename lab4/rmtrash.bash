#!/bin/bash

read -r givenFile <<< "$1"
dirCall=$(pwd)
if [[ -z $(find $dirCall -type f -name "$givenFile") ]]
then
    echo "There is no given file in dirictory of current script"
    exit
fi

scriptDir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )
counterFile=$scriptDir/.count
touch $counterFile
currentCnt=$(cat $counterFile)
if [[ -z  $currentCnt ]]
then
    currentCnt=0
fi


outputDir=$HOME/.trash
mkdir -p $outputDir

ln -- "$givenFile" $outputDir/$currentCnt
rm -- "$givenFile"

outputFile=$HOME/.trash.log
touch $outputFile
pathToGivenFile=$dirCall/"$givenFile"

echo "$pathToGivenFile-$currentCnt" >> $outputFile

((currentCnt+=1))
echo "$currentCnt" > $counterFile

