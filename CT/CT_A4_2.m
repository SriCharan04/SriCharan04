%Credits to Suprasidh
%defining necessary variables
T = 1073:50:1273;   %K
K1= exp(-17249./(T+16.247));
K2= exp(-39649./(T+32.366));
x = zeros(5,2);

%% fsolve loop ahead
x0=[1,1]; %guess array
disp("The roots of the equation are:")
for i=1:5
    k1=K1(i);
    k2=K2(i);
    x(i,:) = fsolve(@root,x0,optimset('Display','off'));
end
x

%% Function
function f = root(x)
    global k1 k2;
    n_t=100;
    f(1) = x(1)*(x(1)+2*x(2)) - (n_t - x(1) - x(2))*(n_t + x(1) + 2*x(2))*k1;
    f(2) = x(2)*(x(1)+2*x(2))^2 - ((n_t - x(1) - x(2))*(n_t + x(1) + 2*x(2))^2)*k2;
end
