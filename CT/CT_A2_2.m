%Task 2a, 2b
del = 0.525;
epsilon = 0.243;
f = @(lambda) lambda-del*exp(lambda/(1+epsilon*lambda));
x = linspace(-20,20,200);
y = f(x);

figure;
plot(x,y);
noofroots = 3;

%Task 2c
del = 0.525;
epsilon = 0.243;
f = @(lambda) lambda-del*exp(lambda./(1+epsilon*lambda));
f_prime = @(lambda) lambda-(del/(1+epsilon*lambda)^2)*exp(lambda./(1+epsilon*lambda));

tol = 10^(-4);
x0 = 1.8;
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
    xi = x0 - (f(x0)/f_prime(x0));
    tol_it = abs((xi-x0)/xi);
end

roots(1) = root;
x0 = 4.6;

%c/p ing the same code for different x0 values
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
    xi = x0 - (f(x0)/f_prime(x0));
    tol_it = abs((xi-x0)/xi);
end

roots(2) = root;
x0 = 10;

%c/p ing the same code for different x0 values
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
    xi = x0 - (f(x0)/f_prime(x0));
    tol_it = abs((xi-x0)/xi);
end

roots(3) = root;

%Task 2d 
del = 0.525;
epsilon = 0.243;
f = @(lambda) lambda-del*exp(lambda./(1+epsilon*lambda));
x0 = 2.5;
x1 = 7.0;
x2 = (x0+x1)/2;
tol_it = abs(x2-x1/x2+x1);
tol = 10^(-4);
iteration = 1;
while iteration < 100
    if (f(x2) > 0)
        x0 = x2;
    else
        x1 = x2;
    end
    x2 = (x0+x1)/2;
    tol_it = abs(x2-x1/x2+x1);
    root = x2;
    iteration = iteration + 1;
end
