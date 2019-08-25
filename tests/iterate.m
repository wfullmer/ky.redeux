tic
main;
toc

%% 

startup_fig;

dat = importdata('KY_tE.dat');
dat2 = importdata('modKY_tE.dat');

N = size(dat,1);
N2 = size(dat2,1);

Ef = zeros(N,1);
Ef2 = zeros(N2,1);
for i = 501:N-501
Ef(i) = mean(dat(i-500:i+500,2));
end
for i = 501:N2-501
Ef2(i) = mean(dat2(i-500:i+500,2));
end
plot(dat(:,1),Ef,'-k')
hold on
plot(dat2(:,1),Ef2,'-r')