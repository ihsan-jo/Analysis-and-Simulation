clc;
clear;
close all;

Kr = 10000;
Kv = 10000;
K0 = 0;
J = 0.0013;
L = 0.06;
br = 2.89;
b0 = 2.89;

%% -----------------------------
%  State-space matrices from your notebook
%  x = [q1; p5; q7; q9]
%  u = Xin
%  y = [Fin; theta]
%% -----------------------------
A = [  0        L/J      0       0  ;
      -K0/L   -b0/J   Kv/L      0  ;
       0      -L/J     0       0  ;
       0        0      0       0  ];

B = [0;
     0;
     1;
     1];          % multiplies Xin

C = [0   0   Kr   Kv ;   % Fin = q7/C9 + q9/C7 + R*Xin
     0   0  -1/L   1/L];   % theta row (as in your C matrix)

D = [br ;          % Fin has R * Xin
     0 ];         % theta has no direct Xin term in this models

% Build state-space object
sys = ss(A,B,C,D);

%% -----------------------------
%  1) Frequency response (Bode)
%% -----------------------------
figure;
omega = logspace(-1, 6, 100); % frequency range from 0.1 to 1000 rad/s
bode(tf('s')*sys, omega)
grid on;
title('Bode plot: X_{in} \rightarrow [F_{in}, \theta]');

b0_new = [1 3 5];
br_new = [1 3 5];

%% -----------------------------

% create new systems with different b0 and br values
A1 = [  0        L/J      0       0  ;
      -K0/L   -b0_new(1)/J   Kv/L      0  ;
       0      -L/J     0       0  ;
       0        0      0       0  ];


sys1 = ss(A1,B,C,D);

A2 = [  0        L/J      0       0  ;
      -K0/L   -b0_new(2)/J   Kv/L      0  ;
       0      -L/J     0       0  ;
       0        0      0       0  ];


sys2 = ss(A2,B,C,D);

A3 = [  0        L/J      0       0  ;
      -K0/L   -b0_new(3)/J   Kv/L      0  ;
       0      -L/J     0       0  ;
       0        0      0       0  ];

sys3 = ss(A3,B,C,D);

% plot bode for all three systems
% use hold on and legend for comparison
figure;
bode(tf('s')*sys, omega)
hold on;
bode(tf('s')*sys1, omega)
bode(tf('s')*sys2, omega)
bode(tf('s')*sys3, omega)
grid on;
legend('b0 = 2.89', 'b0 = 1', 'b0 = 3', 'b0 = 5');
title('Bode plot: X_{in} \rightarrow [F_{in}, \theta] for varying b0');

%% -----------------------------
%  Vary br values
%% -----------------------------

% create new systems with different br values
D1 = [br_new(1);
      0];

sysb1 = ss(A,B,C,D1);

D2 = [br_new(2);
      0];

sysb2 = ss(A,B,C,D2);

D3 = [br_new(3);
      0];

sysb3 = ss(A,B,C,D3);

% plot bode for all three systems with varying br
figure;
bode(tf('s')*sys, omega)
hold on;
bode(tf('s')*sysb1, omega)
bode(tf('s')*sysb2, omega)
bode(tf('s')*sysb3, omega)
grid on;
legend('br = 2.89', 'br = 1', 'br = 3', 'br = 5');
title('Bode plot: X_{in} \rightarrow [F_{in}, \theta] for varying br');


