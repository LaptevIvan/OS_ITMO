#!/bin/bash
 
file=4_5_out
tfile=temp

echo -n "" > $file


for dir in /proc/[0-9]*; 
do
  pid=$(basename "$dir")
  if [[ -d "$dir" ]] 
  then
    ppid=$(cat "$dir/status" | grep "PPid:" | awk '{
      ppid = $2
      print ppid
  }')
  art=$(cat "$dir/sched" | awk '
    BEGIN{
      time = 0
    }

    {
      curProperty=$1
    if (curProperty == "se.sum_exec_runtime") {
      time = $3
    } else if (curProperty == "nr_switches") {      
      nrSwitch=$3
      print time/nrSwitch
      exit 0
    }
  }')
  echo "$pid $ppid $art" >> $file
  
  fi
done

sort -k2n $file | awk '{
  printf "ProcessID=%d : Parent_ProcessID=%d : Average_Running_Time=%.6f\n", $1, $2, $3
}' > $tfile && mv $tfile $file

