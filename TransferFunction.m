Kr = 10000;      % N/m
Kv = 10000;      % N/m
Ko = 0;          % N/m

J  = 0.0013;     % kg*m^2
L  = 0.06;       % m (converted from 6 cm)

br = 2.89;       % N*s/m
bo = 2.89;       % N*s/m

% Transfer function for the system
s = tf('s');

K = ((Kr+br*s+Kv) - ((Kv*L)^2/(J*s^2 + bo*s + (Kv+Ko)*L^2)));
% Display the transfer function
disp('The transfer function K(s) is:');
K

% create bode plot
bode(K);
grid on;