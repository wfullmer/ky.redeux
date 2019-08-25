
%
startup_fig;

%import data
LLEt = importdata('LLE.dat');

%set up constants
L = size(LLEt,1);  %total length of the sample (#)
tend = LLEt(L,1);  %final time from simulation (time)
T = 1000.0;         %averaging window (time)
N = round(tend/T); %number of averaging windows
l = round(L/N);    %length of each window (#)
LLEw = zeros(N,1); %window averaged LLE's 

for tt = 1:N
    ws = l*(tt-1)+1;
    we = ws + l;
    LLEw(tt) = mean(LLEt(ws:we,2));
end


fprintf(1,'>> LLE = %20.12e +/- %20.12e\n',mean(LLEw),std(LLEw));