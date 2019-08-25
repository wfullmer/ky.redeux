%% build RHS "b" vector

for ii = 1:N
    jj = ii;
    
    % u eqn: u_t + u u_x - c v_x = mu u_xx - b u
    ij = 2*ii - 1;
    b(ij) = u(ii)/dt;
    
    % v eqn: v_t + u v_x + (1 + v/2)u_x
    ij = 2*jj;
    b(ij) = v(jj)/dt;
end



%%  build LHS "A" Matrix

%   Left Boundary
ii = 1;
jj = ii;
    
% u eqn: u_t + u u_x - c v_x - mu u_xx
ij = 2*ii - 1;
% u_i-1
A(ij,2*N-1)  = -u(ii)/(2.0d0*dx) - mu/dx^2;
% v_i-1
A(ij,2*N)  = C/(2.0d0*dx);
% u_i
A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B;  % real KY doesn't have sink in u-eqn
% v_j
A(ij,ij+1) = 0.0d0;
% u_i+1
A(ij,ij+2) = u(ii)/(2.0d0*dx) - mu/dx^2;
% v_i+1
A(ij,ij+3) = -C/(2.0d0*dx);

% v eqn: 
ij = 2*jj;
% u_i-1
A(ij,2*N-1)  = -(2.0d0 + v(jj))/(4.0d0*dx);
% v_i-1
A(ij,2*N)  = -u(ii)/(2.0d0*dx) - mu/dx^2;
% u_i
A(ij,ij-1) = 0.0d0;
% v_j
A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B;
% u_i+1
A(ij,ij+1) = (2.0d0 + v(jj))/(4.0d0*dx);
% v_i+1
A(ij,ij+2) = u(ii)/(2.0d0*dx) - mu/dx^2;

%   Interior nodes
for ii = 2:Nm1
    jj = ii;
    
    % u eqn: u_t + u u_x - c v_x - mu u_xx
    ij = 2*ii - 1;
    % u_i-1
    A(ij,ij-2) = -u(ii)/(2.0d0*dx) - mu/dx^2;
    % v_i-1
    A(ij,ij-1) = C/(2.0d0*dx);
    % u_i
    A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B;  % real KY doesn't have sink in u-eqn
    % v_j
    A(ij,ij+1) = 0.0d0;
    % u_i+1
    A(ij,ij+2) = u(ii)/(2.0d0*dx) - mu/dx^2;
    % v_i+1
    A(ij,ij+3) = -C/(2.0d0*dx);
    
    
    % v eqn: 
    ij = 2*jj;
    % u_i-1
    A(ij,ij-3) = -(2.0d0 + v(jj))/(4.0d0*dx);
    % v_i-1
    A(ij,ij-2) = -u(ii)/(2.0d0*dx) - mu/dx^2;
    % u_i
    A(ij,ij-1) = 0.0d0;
    % v_j
    A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B;
    % u_i+1
    A(ij,ij+1) = (2.0d0 + v(jj))/(4.0d0*dx);
    % v_i+1
    A(ij,ij+2) = u(ii)/(2.0d0*dx) - mu/dx^2;
    
end

%   Right Boundary
ii = N;
jj = ii;

% u eqn: u_t + u u_x - c v_x - mu u_xx
ij = 2*ii - 1;
% u_i-1
A(ij,ij-2) = -u(ii)/(2.0d0*dx) - mu/dx^2;
% v_i-1
A(ij,ij-1) = C/(2.0d0*dx);
% u_i
A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B; %real KY doesn't have sink in u-eqn
% v_j
A(ij,ij+1) = 0.0d0;
% u_i+1
A(ij,1)    = u(ii)/(2.0d0*dx) - mu/dx^2;
% v_i+1
A(ij,2)    = -C/(2.0d0*dx);


% v eqn: 
ij = 2*jj;
% u_i-1
A(ij,ij-3) = -(2.0d0 + v(jj))/(4.0d0*dx);
% v_i-1
A(ij,ij-2) = -u(ii)/(2.0d0*dx) - mu/dx^2;
% u_i
A(ij,ij-1) = 0.0d0;
% v_j
A(ij,ij)   = 1.0d0/dt + 2.0d0*mu/dx^2 + B;
% u_i+1
A(ij,1)    = (2.0d0 + v(jj))/(4.0d0*dx);
% v_i+1
A(ij,2)    = u(ii)/(2.0d0*dx) - mu/dx^2;











