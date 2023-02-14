#!/bin/env bash

target=$1
nmap_dir=${PWD}/nmap/

if [ -z $target ]; then
  echo "Provide a target"
  exit
elif [ ! -d $nmap_dir ]; then
  mkdir ${PWD}/nmap/
fi

# PROBING TOP PORTS
echo "Starting probing top ports"
open_ports=$(nmap -T4 $target | grep open | awk -F '/' '{print $1}' | tr "\n" "," | sed 's/,$//g')
# format: 21,22,80

# SCANNING TOP PORTS
echo "Starting scanning top ports"
nmap -T4 $target -p $open_ports -sC -sV -oN ${PWD}/nmap/initial.lst >/dev/null

# PROBING ALL PORTS
echo "Starting allports scan"
nmap -v -T4 $target -p- -oN ${PWD}/nmap/allports.lst
all_ports=$(cat ${PWD}/nmap/allports.lst | grep open | awk -F '/' '{print $1}' | tr "\n" "," | sed 's/,$//g')

# CHECK IF MORE PORTS ARE FOUND
if [[ $open_ports -eq $all_ports ]]; then
  echo "No extra ports were found!"
  rm nmap/allports.lst
  exit 0
fi

# IF MORE PORTS ARE FOUND, SCAN THEM
echo "Starting scanning all ports"
nmap -T4 $target -p $all_ports -sC -sV -oN ${PWD}/nmap/comprehensive.lst >/dev/null

exit
