
mu=15;
m=25;
A=[0 0 1 0;0 0 0 1;0 0 -mu/m 0;0 0 0 -mu/m];
B=8*[0 0;0 0;1/m 0;0 1/m];
C=[1 1 1 1];
D=[];
sys=ss(A,B,C,D)
Ts=0.1;
sysd= c2d(sys,Ts,'zoh')
Ad=sysd.A;
Bd=sysd.B;
% Ad = [1 0 0.09 0;0 1 0 0.09;0 0 0.96 0;0 0 0 0.96];
% Bd = [0.001 0;0 0.001;0.016 0;0 0.016];
% C = [0 0 0 0 1]; 
x0 = [0 1 0 1]';
u = [1;1];
x(:, 1) = Ad*x0 + Bd*u;
for k = 2: 100
    x(:, k) = Ad*x(:, k - 1) + Bd*u;
end
t = 1: 100;
subplot(2, 3, 1);
plot(t, x(1, :))
subplot(2, 3, 2);
plot(t, x(2, :))
subplot(2, 3, 3);
plot(t, x(3, :))
subplot(2, 3, 4);
plot(t, x(4, :))