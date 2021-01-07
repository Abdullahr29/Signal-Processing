t = linspace(-5,5,1000);

x = unitstep(t,-1,1);

figure;
plot(t,x,'linewidth',2);
ylim([0 5]);
set(gca, 'fontsize', 14, 'fontweight', 'bold');
grind on;
xlabel('t');
ylabel('x(t)');
title('Square Wave');

