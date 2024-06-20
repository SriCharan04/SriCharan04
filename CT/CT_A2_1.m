%TASK 1a
%define required variables
del = 0.2;
f = @(lambda) del*exp(lambda)-lambda;
f_prime = @(lambda) del*exp(lambda)-1;
x0 = 3;
tol = 10^(-4);
counter = 1;

%looping with tol_it sentinel in Newton-Raphson method
xi = x0 - (f(x0)/f_prime(x0));
tol_it = abs((xi-x0)/xi);
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
    xi = x0 - (f(x0)/f_prime(x0));
    tol_it = abs((xi-x0)/xi);

    %incrementing counter for every iteration
    counter = counter + 1;
    arr(counter) = xi;

end
x0 = 3;

%TASK 1b
%define required variables
del = 4;
f = @(lambda) del*exp(lambda)-lambda;
f_prime = @(lambda) del*exp(lambda)-1;
x0 = 0;
tol = 10^(-4);
counter = 1;

%looping with tol_it sentinel in Newton-Raphson method
xi = x0 - (f(x0)/f_prime(x0));
tol_it = abs((xi-x0)/xi);
while tol_it >= tol
    %exiting loop if diverges
    if (counter > 10)
        disp("Diverging, root is not in the vicinity!")
        break;
    end
    %updating the contents in the previous iteration
    x0 = xi;
    root = xi;
    arrb(counter) = xi;
    xi = x0 - (f(x0)/f_prime(x0));
    tol_it = abs((xi-x0)/xi);

    %incrementing counter for every iteration
    counter = counter + 1;
    arr(counter) = xi;

end
x0 = 0;

%Task 1c 
x = linspace(1,5,5);
f1 = @(lambda) 0.2*exp(lambda);
f2 = @(lambda) 4*exp(lambda);
y = f1(x);
z = f2(x);

figure;
plot(x,y,x,x);
%as we can see for positive x, the two graphs intersect near x = 2.5. So the root for the following equation should be near x = 2.5. So, the root found, is verified. 

figure;
plot(x,z,x,x);
%as we can see for positive x, the two graphs are not inttersecting. So, the root not being found is justifiable.

