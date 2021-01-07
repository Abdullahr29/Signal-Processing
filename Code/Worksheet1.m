%%Answers for W1 MATLAB
%Q1
a = 100:-1:0;
b = 1/101:1/101:100/101;
c = 2.^(0:15); 
%Q2
r = 2;
n = 4;
S = sum(r.^(0:n+1));
function a = adder(r,n)
    a = sum(r.^(0:n+1));
end
function l = loop(r,n)
    total = 0;
    for i = 0:n+1
        total = total + r^i;
    end
    l = total;
end 
%Q3
%Seperate m file
%Q4
y3 = 2*exp(-j*2*pi*t);
plot(y3);
figure(2)
plot(t,real(y3))
hold on
plot(t, imag(y3))



