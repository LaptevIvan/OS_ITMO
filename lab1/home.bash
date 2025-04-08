#!/bin/bash


echo $PWD | grep -q $HOME && exit 0 || echo "Error: the script was not launched from the home directory" && exit 1
