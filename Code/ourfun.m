function F=ourfun(x)
alpha = 1;
beta = 1;
gam = 0.3;
F= [(alpha/(1 + x(2)^4))-gam*x(1);(beta/(1+x(1)^4))-gam*x(2)];
end