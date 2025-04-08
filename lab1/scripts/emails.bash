#!/bin/bash

file=etc_emails.lst 

touch ${file}
grep -hoREI "[[:alpha:].+-]+@[[:alpha:]-]+\.[[:alpha:].-]+" "/etc" | sort | uniq | tr '\n' ','  > $file

sed -i '$s/,$//' $file
