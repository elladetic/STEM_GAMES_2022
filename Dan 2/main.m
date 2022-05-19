%Rješenje zadatak 2
vector_1 = [11/7, 0; 0, 11/8];
x_0 = [0,0];
x_1 = projection(vector_1, x_0);
vector_2 = [3/2, 0; 0, 3/4];
x_2 = projection(vector_2, x_1);
x_3 = projection(vector_1, x_2);
x_4 = projection(vector_2, x_3);
x_5 = projection(vector_1, x_4);

figure(1)
f = @(x) (11-7*x) / 8 ;
g = @(x) (3-2*x) / 4;
fplot(f, [-2,3], 'cyan')
hold on
fplot(g, [-2,3], 'g')
hold on
grid on
xL = xlim;
yL = ylim;
line([0 0], yL);  %x-axis
line(xL, [0 0]);

plot(x_0(1), x_0(2), 'oblack')
plot(x_1(1), x_1(2), 'or')
plot(x_2(1), x_2(2), 'or')
plot(x_3(1), x_3(2), 'or')
plot(x_4(1), x_4(2), 'or')
plot(x_5(1), x_5(2), 'or')
