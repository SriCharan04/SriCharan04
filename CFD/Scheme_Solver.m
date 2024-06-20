%Defining important variables
% Number Of Space iterations and Space Steps
i = 100;
L = 100;
del_x = L/i;

%Number of Time Steps
n = 500;
time = 100;
del_t = time/n;

%Constant C and a
C = 1;
a = 1;

%Maximum and Minimum range of array to be operated
i_min = 2;
i_max = i - 1;

%Computing Courant Number
sigma = a*del_t/del_x;

%Initialising Temperature array
T_ini = C * sin(pi*linspace(0,i,i)/i);

T = T_ini;
T_p = T_ini;

%Exact solution at t = 100s
T_xact = T * exp((-a*pi*pi*100)/(i*i));
for k = 1:i
    y = FTCSI(T,a,del_t,del_x,i_min,i_max);
    T = y;
end

figure;
xlim([0 1])
plot(linspace(0,i,i),T)
title(["FTCS Implicit at $\sigma$ = ", sigma],"Interpreter","latex")
saveas(gcf,"fig13.pdf")

figure;
xlim([0 1])
plot(linspace(0,i,i),T_xact)
title(["Actual solution at $\sigma$ = ", sigma],"Interpreter","latex")
saveas(gcf,"fig14.pdf")
for k = 1:i
    z = FTCSE(T_ini,a,del_t,del_x,i_min,i_max);
    T_ini = z;
end
figure;
plot(linspace(0,i,i),T_ini)
title(["FTCS Explicit at $\sigma$ = ", sigma],"Interpreter","latex")
saveas(gcf,"fig15.pdf")

for l = 1:i
    w = Crank(T_p,a,del_t,del_x,i_min,i_max);
    T_p = w;
end

figure;
xlim([0 1])
plot(linspace(0,i,i),T_p)
title(["Crank-Nicolson at $\sigma$ = ", sigma],"Interpreter","latex")
saveas(gcf,"fig16.pdf")

function y = FTCSI(b,a,del_t,del_x,i_min,i_max)
% Difference eqn is of form u_i^n+1 - u_i^n =
% (a*del_t/del_x*del_x)*(u_i+1^n+1 - 2*u_i^n+1 + u_i-1^n+1)
    
    %Constructing A matrix
    A = [];

    %Front edge effect
    v = zeros([1 98]);
    v(1) = 1 + ((2*a*del_t)/(del_x*del_x));
    v(2) = -(a*del_t)/(del_x*del_x);
    A = cat(1,A,v);
    for j = i_min:i_max-2
        %Creation of a row vector to be appended to a empty matrix
        v = zeros([1 98]);
        v(j-1) = -(a*del_t)/(del_x*del_x);
        v(j) = 1 + ((2*a*del_t)/(del_x*del_x));
        v(j+1) = -(a*del_t)/(del_x*del_x);
        A = cat(1,A,v);
    end

    %back edge effect
    v = zeros([1 98]);
    v(97) = -(a*del_t)/(del_x*del_x);
    v(98) = 1 + ((2*a*del_t)/(del_x*del_x));
    A = cat(1,A,v);
    
    %Constructing T array (same as input vector, acc. to fd equation)
    T = transpose(b(i_min:i_max));
    %Computing y
    y(i_min-1) = 0;
    y(i_min:i_max) = transpose(A\T);
    y(i_max+1) = 0;
end

function y = FTCSE(b,a,del_t,del_x,i_min,i_max)
% Difference eqn is of form u_i^n+1 - u_i^n =
% (a*del_t/del_x*del_x)*(u_i+1^n - 2*u_i^n + u_i-1^n)
    y(i_min-1) = 0
    %Constructing y array, directly from b array
    for in = i_min:i_max
        %Directly writing to result y vector
        y(in) =  (a*del_t/del_x*del_x)*(b(in-1) + b(in+1)) +  (1 - (2*a*del_t/del_x*del_x)) * b(in);
    end
    y(i_max+1) = 0;
end

function y = Crank(b,a,del_t,del_x,i_min,i_max)
% Difference eqn is of form u_i^n+1 - u_i^n =
% (a*del_t/2*del_x*del_x)*(u_i+1^n+1 - 2*u_i^n+1 + u_i-1^n+1 + u_i+1^n - 2*u_i^n + u_i-1^n)
    %Constructing A matrix
    A = [];
    %Front edge effect
    v = zeros([1 98]);
    v(1) = 1 + ((a*del_t)/(del_x*del_x));
    v(2) = -(a*del_t)/(2*del_x*del_x);
    A = cat(1,A,v);
    for j = i_min:i_max-2
        %Creation of a row vector to be appended to a empty matrix
        v = zeros([1 98]);
        v(j-1) = -(a*del_t)/(2*del_x*del_x);
        v(j) = 1 + ((a*del_t)/(del_x*del_x));
        v(j+1) = -(a*del_t)/(2*del_x*del_x);
        A = cat(1,A,v);
    end

    %back edge effect
    v = zeros([1 98]);
    v(97) = -(a*del_t)/(2*del_x*del_x);
    v(98) = 1 + ((a*del_t)/(del_x*del_x));
    A = cat(1,A,v);
    %Constructing T array (needs to be acc. to fd equation
    for j = i_min:i_max
        % Got the count from the loop, but to prevent T to be written from
        % the middle, i subtract 1
        T(j-1) = (1 - (a*del_t)/(del_x*del_x)) * b(j) + ((a*del_t)/(2*del_x*del_x)) * (b(j-1) + b(j+1));
    end
    T = transpose(T);
    
    %Computing y
    y(i_min-1) = 0;
    y(i_min:i_max) = transpose(A\T);
    y(i_max+1) = 0;
end