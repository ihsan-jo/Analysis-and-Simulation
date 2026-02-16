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
     0 ];         % theta has no direct Xin term in this model

% Build state-space object
sys = ss(A,B,C,D);

%% -----------------------------
%  1) Frequency response (Bode)
%% -----------------------------
figure;
omega = logspace(-1, 6, 100); % frequency range from 0.1 to 1000 rad/s
bode(sys, omega)
grid on;
title('Bode plot: X_{in} \rightarrow [F_{in}, \theta]');