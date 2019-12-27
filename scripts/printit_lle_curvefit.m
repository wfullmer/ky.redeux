%
clear all
close all
clc 

% consts 
N = 3000;
a = 0.494;
p = 0.615; 
s = 0.100;
x = linspace(0,3,N+1)';
f = a.*(x - s).^p;

%% fun
%for ii = 1:N+1
%  if x(ii) >= s
%    f(ii) = a*(x(ii) - s)**p; 
%  else
%    f(ii) = 0.; 
%  end
%end

% print out
fid = fopen('lle_fit.dat','w');
for ii = 1:N+1
  if x(ii) >= s
    fprintf(fid,'%20.12e\t%20.12e\n',x(ii),f(ii)); 
  end
end
fclose(fid);

% eor EOR EOF eof