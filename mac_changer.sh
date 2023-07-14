#!/bin/bash

# Author: demonsoulz92
echo "Author: demonsoulz92"

if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./mac_changer.sh -i INTERFACE -m MAC_ADDRESS"
    exit 1
fi

while getopts "i:m:" opt; do
  case $opt in
    i)
      INTERFACE=$OPTARG
      ;;
    m)
      MAC=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

function change_mac {
    echo "[+] Changing MAC address for $INTERFACE to $MAC"
    sudo ifconfig $INTERFACE down
    sudo ifconfig $INTERFACE hw ether $MAC
    sudo ifconfig $INTERFACE up
}

function get_current_mac {
    CURRENT_MAC=$(ifconfig $INTERFACE | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
    echo "Current MAC = $CURRENT_MAC"
}

get_current_mac
change_mac
get_current_mac
