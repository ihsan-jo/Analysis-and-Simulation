Kr = 10000;      % N/m
Kv = 10000;      % N/m
Ko = 0;          % N/m

J  = 0.0013;     % kg*m^2
L  = 0.06;       % m (converted from 6 cm)

br = 2.89;       % N*s/m
bo = 2.89;       % N*s/m

% state space
A = [0 1; -((Kr+Kv)/J) -(br/ J)]; B = [0; (Kv*L)/J]; C = [1 0]; D = 0; sys_ss = ss(A,B,C,D); disp('The state-space representation is:'); disp(sys_ss);