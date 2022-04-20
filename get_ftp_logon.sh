#!/bin/bash
for arg in "$@"; do
  input=$(tshark -r $arg -Y ftp)
  for i in $(echo "$input" | grep USER | awk '{print $10}'); do
    if [ 530 == $(echo "$input" | grep -A 3 $i | grep "cannot" | awk '{print $9}') ]; then
      echo "failed logon attempt"
    else
      echo "suecesfull logon attempt"
    fi
    echo "$input" | grep -A 3 $i | grep "USER\|PASS" | awk '{print "    "$9" "$10}'
  done
done
