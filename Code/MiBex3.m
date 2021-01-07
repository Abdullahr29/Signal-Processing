close all
clear all

k = 3/16;
h = 0.01;
x(1) = 0;
t = (0:h:100);
sig = 0.1;

figure(1)
for i = 1:2000
    for j = 1:length(t)-1
        x(j+1) = x(j) + h*(-k*x(j)) +sig*sqrt(h)*randn;
    end
    y(i) = x(length(t)-1);
end

histogram(y)
stdev = std(y);
mea = mean(y);

fprintf("Mean and standard deviation is: %f, %f\n", mea, stdev);

%%%%%%%%%%%%%%%%%%%%
figure(2)
sig = 5;
for i = 1:2000
    for j = 1:length(t)-1
        x(j+1) = x(j) + h*(-k*x(j)) +sig*sqrt(h)*randn;
    end
    z(i) = x(length(t)-1);
end
histogram(z)
stdev = std(z);
men = mean(z);


fprintf("New mean and standard deviation is: %f, %f\n", men, stdev);


% figure(2)
% hold on
% y = y./20;
% xA = x(1)*exp(-k*t);
% plot(t,y);
% plot(t,xA);
% 
% mse = mean((y - xA).^2);
% 
% fprintf("Mean squared error is: %f \n", mse);


