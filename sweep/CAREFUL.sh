#!/usr/local/bin/bash
#
#
# This is a main controller program to create Sx # of simulations 
#
#

#create directories and mfix.dat files from doe.dat file 
c=1
cstp=20
while [ $c -le $cstp ]; do 
#copy tmp dir
  cp -r tmp c$c
#make main.m
  echo 'clear all'  >  main.m
  echo 'close all'  >> main.m
  echo 'clc'        >> main.m
  echo 'tic'        >> main.m
  echo 'ci = '$c';' >> main.m
  cat main.tail     >> main.m
  mv main.m c$c/
  cd c$c 
  octave main.m > scn.txt & 
  cd ../
#repeat 
  c=$[$c+1]
done

wait 
exit



