a = 2;
b = 6;
x = 1.1;
y = 2.3;
Ex = 0;
Ey = 0;

for n = 1:100
    Ex = Ex + ((60*(-1)^(n+1))/(a*sinh((n*pi*b)/a)))*cos((n*pi*x)/a)*sinh((n*pi*y)/a);
    Ey = Ey + ((60*(-1)^(n+1))/(a*sinh((n*pi*b)/a)))*sin((n*pi*x)/a)*cosh((n*pi*y)/a);
end 

Exy = (Ex^2 + Ey^2)^0.5;
Ed = 180 - atand(abs(Ey)/abs(Ex));

disp("X term of E:   " + Ex);
disp("Y term of E:   " + Ey);
disp("Magnitude of E:   " + Exy);
disp("Direction of E in degrees:   " + Ed);


