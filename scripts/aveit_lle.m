%
clear all
close all
clc 

Nc     = 201;
Nb     = 10;
Nt     = 10000;
Ntb    = 1000; 
cvLLE = zeros(Nc,3); %c, LLE, CI 


for ic = 1:201
  %import data 
  dir   = strcat('../c',num2str(ic));
  fname = strcat(dir,'/LLE.dat');
  fid   = fopen(fname,'r');
  indat = zeros(Nt+1,2);
  for ii = 1:Nt+1
    indat(ii,:) = (fscanf(fid,'%f',2))';
  end
  fclose(fid);

  %trim data, first point is garbage
  indat(1,:) = [];

  % average into 10 bins 
  LLEbin = zeros(Nb,1); 
  for ib = 1:Nb
    iio = (ib-1)*Ntb;
    LLEbin(ib) = mean(indat(iio+1:iio+Ntb,2));
  end

  %store 
  Fs = 2.262157; 
  cvLLE(ic,1) = double(ic + 15)/100.0d0; 
  cvLLE(ic,2) = mean(LLEbin);
  cvLLE(ic,3) = Fs*std(LLEbin)/sqrt(10.0);

end


% print out
fid = fopen('cvLLE.dat','w');
for ic = 1:Nc
  fprintf(fid,'%5.3f\t%20.12e\t%20.12e\n',cvLLE(ic,1:3)); 
end
fclose(fid);


% eor EOR EOF eof
