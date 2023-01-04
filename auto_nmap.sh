#!/bin/env bash

target=$1
nmap_dir=${PWD}/nmap/


if [ -z $target ]; then
  echo "Provide a target"
  exit
elif [ ! -d $nmap_dir ]; then
  mkdir ${PWD}/nmap/
fi

echo "1. Starting probing top ports"
open_ports=$(nmap -T4 $target | grep open | awk -F '/' '{print $1}' | tr "\n" "," | sed 's/,$//g')
# format: 21,22,80

echo "2. Starting scanning top ports"
nmap -T4 $target -p $open_ports -sC -sV -oN ${PWD}/nmap/initial.lst >/dev/null

echo "3. Starting allport scan"
all_ports=$(nmap -T4 $target -p- -oN ${PWD}/nmap/allports.lst | grep open | awk -F '/' '{print $1}' | tr "\n" "," | sed 's/,$//g')

if [[ $open_ports -eq $all_ports ]]; then
  echo "No extra ports were found!"
  rm nmap/allports.lst
  exit 0
fi

echo "4. Starting scanning all ports"
nmap -T4 $target -p $all_ports -sC -sV -oN ${PWD}/nmap/comprehensive.lst >/dev/null

exit
