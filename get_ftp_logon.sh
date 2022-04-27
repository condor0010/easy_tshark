#!/bin/bash
for arg in "$@"; do
  input=$(tshark -r $arg -Y ftp)
  for i in $(echo "$input" | grep USER | awk '{print $10}'); do
    if [ -Z $(echo "$input" | grep -A 3 $i | grep "cannot" | awk '{print $9}') ]; then
      echo "sucessfull logon attempt"
    else
      echo "sfailed logon attempt"
    fi
    echo "$input" | grep -A 3 $i | grep "USER\|PASS" | awk '{print "    "$9" "$10}'
  done
done

