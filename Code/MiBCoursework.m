clear all;
close all;

r = 0.4;%parameter r
k = 13;%parameter k

x = 0:0.1:50;%defining the x axis
h = r*(1-x./k);%defining h(x)
g = (x)./(1+x.^2);%defining g(x)
t = r.*x.*(1-x./k) - (x.^2)./(1+x.^2);

%setting up and plotting the figure of the h(x) and g(x)
figure(1);
hold on
plot(x,g);
plot(x,h);
plot(x,t);
title("Plot of g(x) and h(x) at k = 13 and r = 0.8");
xlim([0,20]);
ylim([0,2]);

grid minor;
xlabel("x");
ylabel("x dot");

%finding the intersection
[xi, yi] = polyxpoly(x,g,x,h)
plot(xi,yi,'ok')

legend("g(x)", "h(x)", "x dot = 0", "Intersection");

f = @(t,x)[(r*x(1))*(1-(x(1)/k)) - (x(1)^2)/(1 + x(1)^2)];
    
x0 = 0;

[t,x] = ode45(f,[0 100], x0);

figure(2)
hold on
plot(t,x,"r")

x0 = 0.4;

[t,x] = ode45(f,[0 100], x0);

plot(t,x,"b")

x0 = 0.6;

[t,x] = ode45(f,[0 100], x0);

plot(t,x)

x0 = 0.9;

[t,x] = ode45(f,[0 100], x0);

plot(t,x)

x0 = 1.4;

[t,x] = ode45(f,[0 100], x0);

plot(t,x)

x0 = 1.9;

[t,x] = ode45(f,[0 100], x0);

plot(t,x)

x0 = 16.7285;

[t,x] = ode45(f,[0 100], x0);

plot(t,x)
legend("x(t) for x0 = 0","x(t) for x0 = 0.4","x(t) for x0 = 0.6","x(t) for x0 = 0.9","x(t) for x0 = 1.4","x(t) for x0 = 1.9", "x(t) for x0 = 16.72"); 
title("x(t) for different initial conditions");
grid minor;
xlabel("t");
ylabel("x");