%Runge Kutta method:
counter = 0;
h = 0.01;
x0 = 0
y0 = 2;
start_p = 0;
end_p = 3;
N = (end_p-start_p)/h;
x = linspace(start_p,end_p,N);
while (x0 < 3)
    [y,e,counter] = compute_cycle(x0,y0,h,counter);
    if e < 0.00005
        h = 2*h
    end
    while e > 0.0001
        h = h/2
        [y,e,counter] = compute_cycle(x0,y0,h,counter);
    end
    x0 = x0 + h;
    y0 = y;
end
y
counter


function [y_2,e,counter] = compute_cycle(x0,y0,h,counter)
    [y_1,counter] = runge(x0,y0,h,1,counter);
    [y_2,counter] = runge(x0,y0,h/2,2,counter);
    e = abs(y_2-y_1)/y_1;
end
    

function [y,counter] = runge(x0,y0,h,no,counter)
    x = x0;
    y = y0;
    for i = 1:no
        [k1,counter] = f(x,y,counter);
        [k2,counter] = f(x+(h/2),y+(k1*h/2),counter);
        [k3,counter] = f(x+(h/2),y+(k2*h/2),counter);
        [k4,counter] = f(x+h,y+(k3*h),counter);

        y = y0 +(k1 + 2*k2 +2*k3 +k4)*h/6;
        y0 = y;
        x = x + h;
    end
end
function [y,counter] = f(x,y,counter)
    y = 5*exp(0.75*x)-0.25*y;
    counter = counter + 1;
end