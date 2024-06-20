clc;
clear;

%Task 2
t = linspace(0,10,100);
y0 = 1;
z0 = 0;

%with ode15s
yanint = stiff_int(t);
[x,y] = ode15s(@stiff,[0 10],[1 0]);

%ode15 solution in green
figure;
plot(x,y(:,2),'g--o')

%analytical solution in the blue
figure;
plot(t,yanint(:,2),'b:o')

%As we can see, the graph has very high negative slope for t less than
%zero, and then, it increases with complaratively small sloeps magnitude.
%So, there is a stiff component to this ODE.

%plots superposed
figure;
plot(x,y(:,2),'g--o',t,yanint(:,2),'b:o')

%now with ode45
[x_t,y_t] = ode45(@stiff,[0 10],[1 0]);

%plot of ode45 in red, 
figure;
plot(x_t,y_t(:,2),'r--o')

%As we can see, ode45 first, fails to capture the transient part, as the
%number of points are inadequate for the vry steep slope, and second,
%calculates the stady state part with excessively more numnber of points,
%thus resulting in delayed results.
%formulated functions
%Task 2
function y = stiff(t,x)
    y = zeros(2,1);
    y(1) = 98*x(1) + 198*x(2);
    y(2) = -99*x(1) - 199*x(2);
end

function y = stiff_int(t)
    y(:,1) = 2*exp(-t)-exp(-100*t);
    y(:,2) = -exp(-t)+exp(-100*t);
end