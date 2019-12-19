%
clear all
close all
clc 

Nc     = 201;
Nb     = 10;
Nt     = 10000;
Ntb    = 1000; 
Eu     = zeros(Nc,7); %U, CI, u, CI, UU+uu, CI
Ev     = zeros(Nc,7); %V, CI, v, CI, VV+vv, CI

for ic = 1:201
  %import data 
  dir   = strcat('../c',num2str(ic));
  fname = strcat(dir,'/STAT.dat');
  fid   = fopen(fname,'r');
  indat = zeros(Nt+1,6); %time,mean(u),std(u),mean(v),std(v)
  for ii = 1:Nt+1
    time          =  fscanf(fid,'%f',1);
    indat(ii,1:2) = (fscanf(fid,'%f',2))';
    indat(ii,4:5) = (fscanf(fid,'%f',2))';
  end
  fclose(fid);

  %add total energy statistic
  indat(:,3) = indat(:,1).^2 + indat(:,2).^2;
  indat(:,6) = indat(:,4).^2 + indat(:,5).^2;

  %average into 10 bins 
  STATbin = zeros(Nb,6); 
  for ib = 1:Nb
    iio = (ib-1)*Ntb;
    STATbin(ib,:) = mean(indat(iio+1:iio+Ntb,:));
  end

  %store 
  Fs = 2.262157; 

  cm(ic,1) = double(ic - 1)/100.0d0; 
 
  Eu(ic,1) = mean(STATbin(:,1));
  Eu(ic,2) = Fs*std(STATbin(:,1))/sqrt(10.0);
  Eu(ic,3) = mean(STATbin(:,2));
  Eu(ic,4) = Fs*std(STATbin(:,2))/sqrt(10.0);
  Eu(ic,5) = mean(STATbin(:,3));
  Eu(ic,6) = Fs*std(STATbin(:,3))/sqrt(10.0);
  
  Ev(ic,1) = mean(STATbin(:,4));
  Ev(ic,2) = Fs*std(STATbin(:,4))/sqrt(10.0);
  Ev(ic,3) = mean(STATbin(:,5));
  Ev(ic,4) = Fs*std(STATbin(:,5))/sqrt(10.0);
  Ev(ic,5) = mean(STATbin(:,6));
  Ev(ic,6) = Fs*std(STATbin(:,6))/sqrt(10.0);
end


% print out
fid = fopen('stats_u.dat','w');
for ic = 1:Nc
  fprintf(fid,'%5.3f\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',cm(ic),Eu(ic,1:6)); 
end
fclose(fid);
%
fid = fopen('stats_v.dat','w');
for ic = 1:Nc
  fprintf(fid,'%5.3f\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',cm(ic),Ev(ic,1:6)); 
end
fclose(fid);


% eor EOR EOF eof
