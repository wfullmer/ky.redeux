%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
tic
%
%
% Required User Input
N = 256;                %only count periodic boundary as one, another added automatically
x_start = -1.0d0*pi;    %domain start
x_end   = 1.0d0*pi;     %domain end
dt      = 1.0d-2;       %time stop
tend    = 10000. + dt;         %end time
C       = 2.16d0;        %
mu      = 0.05d0;       %viscosity
B       = mu*16.0d0;        %dissipation
%
% preliminaries
Np2 = N + 2;
Np1 = N + 1;
Nm1 = N - 1;
Nm2 = N - 2;
Nc  = Np1/2;
fignum = 0;
%plot_time = 4.0;
%plot_dt = 10.;
%
%
% LLE variables
del00   = 1.0d-08;
del0    = sqrt(2.0d0*double(N))*del00;
lle     = 0.0d0;
lleave  = 0.0d0;
% LLE_start = 100.0; -> LLE_start = 0, set time = - (adjustment period)
%
%
% output files
outLLE  = fopen('LLE.dat','w');
outSTAT = fopen('STAT.dat','w');
outCDim = fopen('CDim.dat','w');
outCDv  = fopen('CDv.dat','w');
outBIu0 = fopen('BIu0.dat','w');
outBIv0 = fopen('BIv0.dat','w');
iotime  = 0.0d0;
iodt    = 1.0d0; 
%
%
% allocate vectors & matrices
%NOTE: x,u are really N long, Np1 is just for plotting
x   = zeros(N,1);
u   = zeros(N,1);
v   = zeros(N,1);
uo  = zeros(N,1);
vo  = zeros(N,1);
up  = zeros(N,1);
vp  = zeros(N,1);
upo = zeros(N,1);
vpo = zeros(N,1);
A   = zeros(2*N,2*N);
b   = zeros(2*N,1);
uv  = zeros(2*N,1);
%
%
% numerical grid
L = x_end - x_start;
dx = L/double(N);
if dx < 0
    dx = dx*-1;
end
x(1) = x_start;
for j = 2:N
    x(j) = x(j-1) + dx;
end
xc(1:N) = x;
xc(Np1) = x_end;
%
%
% Initialize
time = -100.0d0;
u = cos(2.0d0.*x)/2.0d0;
v = sin(2.0d0.*x)/2.0d0;
% initialize the perturbed variables as +/- soln variables, shouldn't need
% to be symmetric since they both have linear sinks now
up = u + del00;
vp = v - del00;
%plot_ux
fignum = fignum + 1;
%plot_time = plot_time + plot_dt;
%
%
%
%     Begin Time March     Begin Time March     Begin Time March     Begin Time March     Begin Time March     Begin Time March
%
%
%
iprint = 0;
while time < tend

    % store old variables for later
    uo = u;
    vo = v;
    upo = up;
    vpo = vp;
    
    %advance to new time and calc the new time solution(s)
    time = time + dt;           % n + 1

    % get the new solution variables
    build_Ab;                    % build A matrix and b vector
   %uv = linsolve(A,b);          % solve for new u, v
    uv = A\b;                    % solve for new u, v
    for ii = 1:N                 % separate into u,v
        %j = i; ij = 2i-1, 2i
        u(ii) = uv(2*ii-1);
        v(ii) = uv(2*ii);
    end      
    
    % get the new perturbed variables
    build_Apbp;                  % build A matrix and b vector
   %uv = linsolve(A,b);          % solve for new u, v
    uv = A\b;                    % solve for new u, v
    for ii = 1:N                 % separate into u,v
        %j = i; ij = 2i-1, 2i
        up(ii) = uv(2*ii-1);
        vp(ii) = uv(2*ii);
    end     

    % calc new seperation, del1
    del1 = sqrt(sum((u - up).^2) + sum((v - vp).^2));
%     del1 = 0.0D0;
%     DO ii = fstn, lstn
%      del1 = del1 + (ap(ii) - an(ii))**2
%     END DO
%     DO jj = fstj, lstj-1
%      del1 = del1 + (up(jj) - un(jj))**2
%     END DO
%     del1 = SQRT(del1)

    % calc current LLE 
    lle    = log(del1/del0)/dt;
    lleave = lleave + lle/100.0d0;

    %if ((time > ps_start) .AND. (ABS(LLEc) .LT. 1000.0)) THEN
    if (time + del00 >= iotime)
        fprintf(1,'\tio at time, t = %8.1f\n',time);
        
        iotime = iotime + iodt; 

        % print current LLE, post-process later
        fprintf(outLLE,'%20.12e\t%20.12e\n',time,lleave);
        lleave = 0.0d0;
        
        % calc & print statistics
        fprintf(outSTAT,'%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',time,mean(u),std(u),mean(v),std(v));

        % print 8 equally spaced 
        fprintf(outCDim,'%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',u(1),u(33),u(65),u(97),u(129),u(161),u(193),u(225));
        fprintf(outCDv, '%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\t%20.12e\n',v(1),v(33),v(65),v(97),v(129),v(161),v(193),v(225));


        % calc & print bifurcation diagram
        for ii = 2:N
            if (u(ii)*u(ii-1) < 0)
                v0 = v(ii-1) - u(ii-1)*(v(ii) - v(ii-1))/(u(ii) - u(ii-1));
                fprintf(outBIu0,'%20.12e\n',v0);
            end

            if (v(ii)*v(ii-1) < 0)
                u0 = u(ii-1) - v(ii-1)*(u(ii) - u(ii-1))/(v(ii) - v(ii-1));
                fprintf(outBIv0,'%20.12e\n',u0);
            end
        end
            if (u(1)*u(N) < 0)
                v0 = v(N) - u(N)*(v(1) - v(N))/(u(1) - u(N));
                fprintf(outBIu0,'%20.12e\n',v0);
            end

            if (v(1)*v(N) < 0)
                u0 = u(N) - v(N)*(u(1) - u(N))/(v(1) - v(N));
                fprintf(outBIv0,'%20.12e\n',u0);
            end
    end
    
    % re-normalize perturbation to del0
    up = u + (del0/del1).*(up - u);
    vp = v + (del0/del1).*(vp - v);
        
end
%
%
%close in/out files
fclose(outLLE);
fclose(outSTAT);
fclose(outCDim);
fclose(outCDv);
fclose(outBIu0);
fclose(outBIv0);


toc

%exit;
