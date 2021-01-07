t = 0:0.01:10;
y1 = sin(t);
plot(t,y1)
xlabel('time')
ylabel('sin')
grid ON
grid MINOR
title('Sin Curve')
hold on
y2 = cos(t);
plot(t,y2)
title('Trignometric Curves')
legend
legend('Sin','Cos')

