%% Assignment 1: Exercise 3.3
% limits of the y-axis of both distributions
a = -2.5;
c = 1.5;
d = -1.5;
b = 2.5;
% the two distributions
a1 = (b-a).*rand(10000, 1) + a;
a2 = (c-d).*rand(10000, 1) + d;
hold on
for i=1:10000

        if(a1(i)+a2(i)<1 && a2(i)-a1(i)<1 && abs(a2(i))<1)
            scatter(a1(i),a2(i),'*');
        end
    
end

xlabel('a1')
ylabel('a2')
title('Stable coefficients (a1,a2) for the AR model of order 2')