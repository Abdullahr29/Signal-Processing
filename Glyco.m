clear all;
close all;
%% Setting up the parameters for the ODE and solving the ODE
params.k1  = 1;%using a struct to hold the key values
params.k2  = 0.14;%a value we change throughout the exercise 
params.vin  = 0.5;
x0 = [1 2]; %the initial condition for the ODE

t = [0:0.01:200];%setting time vector
[t, x]  = ode45(@(t,x)GlycoFun(t,x,params),t,x0);%solving ODE using GlycoFun

%plotting the solved x and y of the ODE in time domain
figure(1)
plot(t,x);
grid minor;
title('x(t) and y(t) with respect to time with k2 = 0.14')
xlabel('t');
ylabel('Concentrations x and y');
legend('x(t)','y(t)');
%% Setting up the nullclines and plotting them with the phase plane diagrams of the ODE
y1 = [0:0.01:10];%y axis
xfunc = y1./(params.k2 + (params.k1.*y1.^2));%the x nullcline 
x1 = [0:0.01:10];%x axis
yfunc = sqrt((params.vin - params.k2.*x1)./(params.k1.*x1));%the y nullcline

%plotting the nullclines and phase plane diagrams
figure(2)
hold on
%plotting the nullclines
plot(y1,xfunc,'r');
plot(yfunc,x1,'b');
%plotting the solved ODEs for x and y against each other
plot(x(:,2),x(:,1),'k')
%plotting the initial condition
plot(x(1,2),x(1,1),'ko')
grid minor;
title('Plot of nullclines for k2 = 0.14')
xlabel('y');
ylabel('x');
legend('x nullcline','y nullcline');
