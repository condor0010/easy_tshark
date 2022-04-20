#!/bin/bash
if [ -z $1 ]; then
  echo "please specify a pcap file, $0 <pcap file>"
else
  input=$(tshark -r $1 -Y ftp)
  get_ftp_logon(){
    for i in $(echo "$input" | grep USER | awk '{print $10}'); do
      echo "$input" | grep -A 2 $i | grep "USER\|PASS"
    done
  }
  get_ftp_logon | awk '{print $9" "$10}'
fi
