function xdot = GlycoFun(t,x,params)%the function which returns the ODE

xdot = [params.vin - (params.k2*x(1)) - (params.k1*x(1)*(x(2)^2));%both x dot and y dot of the ODE
        params.k2*x(1) - x(2) + (params.k1*x(1)*(x(2)^2))];

