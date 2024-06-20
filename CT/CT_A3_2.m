%Task 2a,2b
del = 0.525;
epsilon = 0.243;
f = @(lambda) lambda-del*exp(lambda./(1+epsilon*lambda));
x = linspace(-1,10,200);
y = f(x);

figure;
plot(x,y);
noofroots = 3;

%Task 2c
%inititalising variables
del = 0.53;
epsilon = 0.245;
f = @(lambda) lambda-del*exp(lambda./(1+epsilon*lambda));
tol = 10^(-6);

%root is present in x = 2 and x = 3, from graph observation
x0=2;
x1=3;

%for first iteration
xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
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
   %updating values
    xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
   tol_it = abs((xi-x0)/xi);
end

roots(1) = root; 

%root is present in x = 3 and x = 5, from graph observation
x0=3;
x1=5;

%for first iteration
xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
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
   %updating values
    xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
    tol_it = abs((xi-x0)/xi);
end

roots(2) = root; 

%root is present in x = 5 and x = 10, from graph observation
x0=5;
x1=10;

%for first iteration
xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
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
   %updating values
    xi = (x1*f(x0)-x0*f(x1))/(f(x0)-f(x1));
    tol_it = abs((xi-x0)/xi);
end

roots(3) = root;
