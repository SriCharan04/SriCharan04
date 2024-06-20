%defining constants
T_c = 126.2; %K
P_c = 34; %bar
T = 473; %K
P = 10; %bar
R = 8.314; %JK(-1)mol(-1)

%main program
%using fslove to solve non-linear equations
volume_1 = fsolve(@vanderwaals,25);
volume_2 = fsolve(@redlich,5);
disp(["The value of volume obtained as per Vanderwaals equation of state is:"  num2str(volume_1)])
disp(["The value of volume obtained as per Redlich-Kwong equation of state is:"  num2str(volume_2)])

%using Newton-Raphson method to solve non-linear equations
%VanderWaals equation of state
x_0 = 10;
x_i = x_0-(vanderwaals(x_0)/vanderwaals_derivative(x_0));
e_i = abs((x_i-x_0)/x_i);
counter = 1;
iteration_1(counter) = x_i;
while (abs(e_i) >= 0.5)
    x_0 = x_i;
    x_i = x_0-(vanderwaals(x_0)/vanderwaals_derivative(x_0));
    e_i = abs((x_i-x_0)/x_i);
    counter = counter + 1;
    iteration_1(counter) = x_i;
end
iteration_1

figure;
plot(linspace(1,counter,counter),iteration_1);
xlabel('No of Iterations');
ylabel('Relative Error@Vanderwaals');

%Redlich-Kwong Equation of state
x_1 = 10;
x_i = x_1-(vanderwaals(x_1)/vanderwaals_derivative(x_1));
e_i = abs((x_i-x_1)/x_i);
counter = 1;
iteration_2(counter) = x_i;
while (abs(e_i) >= 0.01)
    x_1 = x_i;
    x_i = x_1-(redlich(x_1)/redlich_derivative(x_1));
    e_i = abs((x_i-x_1)/x_i);
    counter = counter + 1;
    iteration_2(counter) = x_i;
end
iteration_2

figure;
plot(linspace(1,counter,counter),iteration_2);
xlabel('No of Iterations');
ylabel('Relative Error@Redlich_Kwong');

%function definition of vanderwaal's equation of state
function value = vanderwaals(v)    
    %defining a and b
    T_c = 126.2; %K
    P_c = 34; %bar
    T = 473; %K
    P = 10; %bar
    R = 8.314; %JK(-1)mol(-1)
    a = 27*R^2*T_c^2/(64*P_c);
    b = R*T_c/P_c;
    
    %function
    value = (R*T/(v-b))-(a/(v^2))-P;
end

function value_prime = vanderwaals_derivative(v)
    %defining a and b
    T_c = 126.2; %K
    P_c = 34; %bar
    T = 473; %K
    P = 10; %bar
    R = 8.314; %JK(-1)mol(-1)
    a = 27*R^2*T_c^2/(64*P_c);
    b = R*T_c/P_c;
    
    %function
    value_prime = -(R*T/((v-b)^2))+(2*a/(v^3));
end

%function definition of redlich-kwong equation of state
function value = redlich(v)    
    %defining a and b
    T_c = 126.2; %K
    P_c = 34; %bar
    T = 473; %K
    P = 10; %bar
    R = 8.314; %JK(-1)mol(-1)

    a = 0.4728*R^2*(T_c^2)/P_c;   
    b = 0.0867*R*T/P_c;
    
    %function
    value = (R*T/(v-b))-(a/(v*((v-b)^2)*(T^0.5)))-P;
end

function value_prime = redlich_derivative(v)
    %defining a and b
    T_c = 126.2; %K
    P_c = 34; %bar
    T = 473; %K
    P = 10; %bar
    R = 8.314; %JK^(-1)mol^(-1)
    a = 0.4728*R^2*T_c^2/P_c;   
    b = 0.0867*R*T/P_c;
    
    %function
    value_prime = (-R*T/(v-b)^2)+(a*(3*v-b)/v^2*(T^(1/2))*(v-b)^3);
end

