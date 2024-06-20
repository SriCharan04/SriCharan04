%Defiining important variables
% Number Of Space iterations and Space Steps
i = 400;
L = 100;
del_x = L/i;

%Number of Time Steps
n = 400;
time = 100;
del_t = time/n;

plot_number = 5;
plot_timesteps = [];
for i = 1:floor(n/plot_number)
    plot_timesteps(i) = plot_number*i;
end

%Constants u, mu, rho, alpha and beta
u = 1;
mu = 1;
rho = 1;
alpha = (u*del_t/2*del_x)
beta = (mu*del_t/del_x*del_x)
%For the solution to be numerically stable
%alpha*alpha <= beta/2 and beta <= 0.5 

%Maximum and Minimum range of array to be operated
i_min = 2;
i_max = i+1;

x = linspace(0,L,i);
T = init(i);

figure;
plot(x,T);
title(["$\alpha$ =",num2str(alpha)," and $\beta$ =",num2str(beta)],"interpreter","latex")
for count = 1:100
    hold on;
    %Ttwo = FTBSCS(T, alpha , beta, i_min, i_max);
    Ttwo = FTCSCS(T, alpha , beta, i_min, i_max);
    T = Ttwo;
    if (ismember(count,plot_timesteps))
        plot(x,T);
    end
end
legend("Time t = 0","Time t = 10","Time t = 20","Time t = 30","Time t = 40","Time t = 50", "Time t = 60","Time t = 70", "Time t = 80","Time t = 90","Time t = 100")

function T = init(i)
    j = floor(i/10);
    Tp = zeros([1 i-j]);
    Tq = ones([1 j]);
    T = cat(2,Tq,Tp);
end

function y = FTCSCS(x, alpha , beta, i_min, i_max)
    pad = zeros;
    x = cat(2,pad,x);
    x = cat(2,x,pad);
    for i = i_min:i_max
        y(i-1) = (beta-alpha)*x(i+1) + (1-2*beta)*x(i) + (beta + alpha)*x(i-1);
    end
end

function y = FTBSCS(x, alpha , beta, i_min, i_max)
    pad = zeros;
    x = cat(2,pad,x);
    x = cat(2,x,pad);
    for i = i_min:i_max
        y(i-1) = (beta)*x(i+1) + (1-2*beta-2*alpha)*x(i) + (beta+2*alpha)*x(i-1);
    end
end