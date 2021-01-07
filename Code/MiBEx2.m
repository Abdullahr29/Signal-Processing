k = 0.25;
h = 0.01;
x(1) = 5;
t = [0: h: 10];

%numerical
for i = 1:length(t)-1
    x(i+1) = x(i) + h*(-k*x(i));
end
figure(1)


xA = x(1)*exp(-k*t);
figure(2)
plot(xA, t);

mse = mean((x - xA).^2);

fprintf("Mean squared error is: %f \n", mse);

xn(1) = 5;
h1 = 0.001;
t1 = [0: h: 10];

xAn = xn(1)*exp(-k*t1);

for i = 1:length(t1)-1
    xn(i+1) = xn(i) + h1*(-k*xn(i));
end

msen = mean((xn - xAn).^2);

fprintf("New mean squared error is: %f \n", msen);



    
    
    
    
    
