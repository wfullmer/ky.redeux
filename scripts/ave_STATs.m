%
clear all
close all
clc 

Nc     = 201;
Nb     = 10;
Nt     = 10000;
Ntb    = 1000; 
cvEu   = zeros(Nc,7); %c, U, CI, u, CI, UU+uu, CI
cvEv   = zeros(Nc,7); %c, V, CI, v, CI, VV+vv, CI

for ic = 1:201
  %import data 
  dir   = strcat('../c',num2str(ic));
  fname = strcat(dir,'/STAT.dat');
  fid   = fopen(fname,'r');
  indat = zeros(Nt+1,2);
  for ii = 1:Nt+1
    indat(ii,1:3) = (fscanf(fid,'%f',3))';
    indat(ii,5:6) = (fscanf(fid,'%f',2))';
  end
  fclose(fid);

  %trim data, first point is garbage
  indat(1,:) = [];

  %add energy statistic
  indat(:,4) = indat(:,2).^2 + indat(:,3).^2;
  indat(:,7) = indat(:,5).^2 + indat(:,6).^2;

  %average into 10 bins 
  STATbin = zeros(Nb,6); 
  for ib = 1:Nb
    iio = (ib-1)*Ntb;
    STATbin(ib,:) = mean(indat(iio+1:iio+Ntb,2:7));
  end

  %store 
  Fs = 2.262157; 

  cvEu(ic,1) = double(ic + 15)/100.0d0; 
  cvEu(ic,2) = mean(STATbin(:,1));
  cvEu(ic,3) = Fs*std(STATbin(:,1))/sqrt(10.0);
  cvEu(ic,4) = mean(STATbin(:,2));
  cvEu(ic,5) = Fs*std(STATbin(:,2))/sqrt(10.0);
  cvEu(ic,6) = mean(STATbin(:,3));
  cvEu(ic,7) = Fs*std(STATbin(:,3))/sqrt(10.0);
  
  cvEv(ic,1) = double(ic + 15)/100.0d0; 
  cvEv(ic,2) = mean(STATbin(:,4));
  cvEv(ic,3) = Fs*std(STATbin(:,4))/sqrt(10.0);
  cvEv(ic,4) = mean(STATbin(:,5));
  cvEv(ic,5) = Fs*std(STATbin(:,5))/sqrt(10.0);
  cvEv(ic,6) = mean(STATbin(:,6));
  cvEv(ic,7) = Fs*std(STATbin(:,6))/sqrt(10.0);
end


% print out
fid = fopen('cvEu.dat','w');
for ic = 1:Nc
  fprintf(fid,'%5.3f\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',cvEu(ic,1:7)); 
end
fclose(fid);
%
fid = fopen('cvEv.dat','w');
for ic = 1:Nc
  fprintf(fid,'%5.3f\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',cvEv(ic,1:7)); 
end
fclose(fid);


% eor EOR EOF eof
