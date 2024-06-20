%Question 1 
%a)initialising variable a and variable b
a = 4.556789;
b = 5.678342;

%b)defining sum of a and b as sum1
sum1 = a + b;

%c)defining difference of b from a as difference1
difference1 = a - b;

%d)defining product of a and b as product1
product1 = a*b;

%e)defining a raised to power b as power1
power1 = a^b;

%f)rounding off variables to 3 significant digits
sum2 = round(sum1,3,"significant");
difference2 = round(difference1,3,"significant");
product2 = round(product1,3,"significant");
power2 = round(power1,3,"significant");

%g)trying out the following commands

fprintf('%.3f\n',1.4986);
fprintf('%.2e\n',1.4986);
