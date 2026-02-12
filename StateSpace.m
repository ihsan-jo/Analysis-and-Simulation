Kr = 10000;      % N/m
Kv = 10000;      % N/m
Ko = 0;          % N/m

J  = 0.0013;     % kg*m^2
L  = 0.06;       % m (converted from 6 cm)

br = 2.89;       % N*s/m
bo = 2.89;       % N*s/m

% states : theta, omega

% state space
A = [ -bo/J, -(Kv + Ko)*L^2/J;
       1    ,  0              ];

B = [ Kv*L/J, 0;
      0   , 0 ];

C = [ 0      1;      % theta = 0*w + 1*theta
      0    1/L;      % x     = (1/L)*theta + Xin
      0  -Kv*L;      % Fin   = -Kw*L*theta + (Kr+Kw)*Xin + br*Xdotin
      0      0 ];    % Xin   = 1*Xin

D = [      0      0;
          0      0;
     (Kr+Kv)    br;
          1      0 ];

% create state space system
sys = ss(A,B,C,D);

% xin = Asin(omega*t)
% xdotin = A*omega*cos(omega*t)

t = 0:0.01:10; % time vector
omega = 2*pi*1; % frequency of input (1 Hz)
A_input = 0.01; % amplitude of input
xin = A_input * sin(omega*t);
xdotin = A_input * omega * cos(omega*t);
input = [xin; xdotin];

% do Lsim
[y,t,x] = lsim(sys, input', t);

% plot results
figure;
subplot(3,1,1);
plot(t, y(:,1));
title('Theta (rad)');
subplot(3,1,2);
plot(t, y(:,2));
title('X (m)');
subplot(3,1,3);
plot(t, y(:,3));
title('Fin (N)');
