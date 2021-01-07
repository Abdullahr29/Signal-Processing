close all;
clear all;

y0 = 7;
x0 = 5;

alpha = 1;
beta = 1;
gam = 0.3;

%dxdt = (alpha/(1 + y^4))-gam*x;
%dydt = (beta/(1+x^4))-gam*y;

f = @(t,x)[(alpha/(1 + x(2)^4))-gam*x(1);(beta/(1+x(1)^4))-gam*x(2)];

[t,xa] = ode45(f,[0 100],[x0 y0]);

figure(1)
hold on
plot(t,xa(:,1))
plot(t,xa(:,2))
legend('X(t)', 'Y(t)')
xlabel('t')

%F = @(u)[(alpha/(1 + x(2)^4))-gam*x(1);(beta/(1+x(1)^4))-gam*x(2)];
figure(2);
hold on;

for i = 1:200
    xi = [i,200-i];
    [y,fval] = fsolve(@ourfun, xi);
    plot(y,fval(:,1));
end
    
