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
      0  -Kv*L];    % Fin

D = [      0      0;
     (Kr+Kv)    br];

% create state space system
sys = ss(A,B,C,D);

% xin = Asin(omega*t)
% xdotin = A*omega*cos(omega*t)
% create bode manually

omega = logspace(-1, 6, 100); % frequency range from 0.1 to 1000 rad/s

figure;
bode(sys(:,1) + tf('s')*sys(:,2), omega)
grid on;

% give subplot title in sequence: theta magnitude, theta phase, Fin magnitude, Fin phase
ax = findall(gcf, 'type', 'axes');
ax(1).set('Title', text('String', 'Theta Magnitude'));
ax(2).set('Title', text('String', 'Theta Phase'));
ax(3).set('Title', text('String', 'Fin Magnitude'));
ax(4).set('Title', text('String', 'Fin Phase'));

