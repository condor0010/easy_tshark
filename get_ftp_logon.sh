#!/bin/bash
for arg in "$@"; do
  input=$(tshark -r $arg -Y ftp)
  for i in $(echo "$input" | grep USER | awk '{print $10}'); do
    if [ -z $(echo "$input" | grep -A 3 $i | grep "cannot" | awk '{print $9}') ]; then
      echo "sucessfull logon attempt"
    else
      echo "failed logon attempt"
    fi
    echo "$input" | grep -A 3 $i | grep "USER\|PASS" | awk '{print "    "$9" "$10}'
  done
done
