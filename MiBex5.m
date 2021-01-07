close all;
clear all;

n = 0.03;
f = @(t,y) [y(2); n*y(2)-y(1)];
t0 = 0;  y0 = [2;10]; 
T = 100;                            % final t-value
[ts,ys] = ode45(f,[t0,T],y0); 
plot(ys(:,1),ys(:,2),'b') 
