%TASK 1a
%define required variables
del = 0.1;
f = @(lambda) del*exp(lambda);
x0=0;
tol = 10^(-3);
counter = 1;

%looping with tol_it sentinel in fixed point method
xi = f(x0);
tol_it = abs((xi-x0));
while tol_it >= tol
    %exiting loop if diverges
    if (tol_it >= 100)
        disp("Diverging, root is not in the vicinity!")
        break;
    end
    %updating the contents in the previous iteration
    x0 = xi;
    root = xi;
    arr(counter) = xi;
    xi = f(x0);
    tol_it = abs((xi-x0));
    root=xi;

    %incrementing counter for every iteration
    counter = counter + 1;
    arr(counter) = xi;
end
x0 = 0;

%TASK 1b
%define required variables
del_p = 2;
f = @(lambda) del*exp(lambda);
x1=0;
tol = 10^(-3);
counter = 1;

%looping with tol_it sentinel in fixed point method
xj = f(x0);
tol_it = abs((xi-x1));
while counter <= 3
    %exiting loop if diverges
    if (tol_it >= 100)
        disp("Diverging, root is not in the vicinity!")
        break;
    end
    %updating the contents in the previous iteration
    x1 = xj;
    rot = xj;
    arrb(counter) = xj;
    xj = f(x1);
    tol_it = abs((xj-x1));
    root=xj;

    %incrementing counter for every iteration
    counter = counter + 1;
    arrb(counter) = xj;
end
x1 = 0;

%task 1c
x = linspace(1,5,5);
f1 = @(lambda) 0.2*exp(lambda);
f2 = @(lambda) 2*exp(lambda);
y = f1(x);
z = f2(x);

figure;
plot(x,y,x,x);
%as we can see for positive x, the two graphs intersect near x = 2.5. So the root for the following equation should be near x = 2.5. So, the root found, is verified. 

figure;
plot(x,z,x,x);
%as we can see for positive x, the two graphs are not inttersecting. So, the root not being found is justifiable.
