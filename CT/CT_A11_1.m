clc;
clear;
%task 1
x_array = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
x0 = x_array(1);
y0 = 10;
yan = anal_int(x_array);

h = 0.5;
[yEuler1,xEuler1] = euler(x0,y0,h,@diff);

h = 0.1;
[yEuler2,xEuler2] = euler(x0,y0,h,@diff);

figure;
plot(x_array,yan,xEuler1,yEuler1,'r:o',xEuler2,yEuler2,'g--o')

[x,y] = ode45(@diff,[0 4],y0);

figure;
plot(x_array,yan,'g--o',x,y,'b:o')
%The solution obtained with ode45 method resembles closely to the
%analytical solution, except that the solution is a little rougher,
%compared to the original solution. had the number of points increased,
%this roughness can be reduced further.

%Task 2


%function formulations
%Task 1
function [y_arr,x_arr] = euler(x0,y0,h,diff_f)
    steps = 4/h;
    y_arr(1) = y0;
    x_arr(1) = x0;
    for i = 2:steps
        y_arr(i) = y_arr(i-1) + diff_f(x0)*h;
        x0 = x0 + h;
        x_arr(i) = x0;
    end
end

function y = diff(x,y)
    y = -2*x^3 + 12*x^2 - 20*x + 8.5;
end

function y = anal_int(x)
    y = -(x.^4)/2 + 4*x.^3 - 10*x.^2 + 8.5*x + 10;
end