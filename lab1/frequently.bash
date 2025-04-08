#!/bin/bash


man bash | grep -o "[[:alpha:]]\{4,\}" | sort | uniq -c | sort -n | tail -3 | awk '{print $2}'
