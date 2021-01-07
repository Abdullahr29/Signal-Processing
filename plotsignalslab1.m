close all;
clear all;
load('MSE_vect1.mat');
load('MSE_vect2.mat');
load('MSE_vect4.mat');
load('MSE_vect8.mat');
load('real_delay1.mat');
load('real_delay2.mat');
load('real_delay4.mat');
load('real_delay8.mat');
hold on
figure(1)
plot(real_delay, MSE_vect, 'b');
plot(real_delay2, MSE_vect2, 'm');
plot(real_delay4, MSE_vect4, 'c');
plot(real_delay8, MSE_vect8, 'g');
grid minor;
xlim([0 50]);
legend('Error M = 1', 'Error M = 2', 'Error M = 4', 'Error M = 8');
title('Estimation error for downsampling factors 1,2,4,8');
xlabel('Time (ms)')
ylabel('% Error')