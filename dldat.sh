#!/bin/bash

## download the zipped data
touch cookies.txt
wget --load-cookies ./cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies ./cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1xlQlr5iosgSdghsBkP9v8jIVoh0yYdg_' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1xlQlr5iosgSdghsBkP9v8jIVoh0yYdg_" -O ky2_data.zip
rm cookies.txt 

## unpack
unzip ky2_data.zip
wait
rm ky2_data.zip 

## go ahead and copy the code used to generate the data in to each dir
## this is basically ./sweep/CAREFUL.sh except we're not running octave 
c=1
cstp=201
while [ $c -le $cstp ]; do
#copy tmp dir
  cp -r sweep/tmp/* ./c$c
#make main.m
  echo 'clear all'    >  main.m
  echo 'close all'    >> main.m
  echo 'clc'          >> main.m
  echo 'tic'          >> main.m
  echo 'ci = '$c';'   >> main.m
  cat sweep/main.tail >> main.m
  mv main.m ./c$c/
#repeat 
  c=$[$c+1]
done

wait
exit






