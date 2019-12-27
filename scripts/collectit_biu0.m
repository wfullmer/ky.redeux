%
clear all
close all
clc 

Nc     = 201;
fid    = fopen('biu0.dat','w');

for ic = 1:201
  %import data 
  dir    = strcat('../c',num2str(ic));
  fname  = strcat(dir,'/BIu0.dat');
  dat    = importdata(fname);
  N      = size(dat,1);
  cm     = double(ic - 1)/100.0d0; 
  for ii = 1:N
    fprintf(fid,'%5.3f\t%20.12e\n',cm,dat(ii)); 
  end
end
fclose(fid);


% eor EOR EOF eof
