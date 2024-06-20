%assn1

%gauss-jordan method
%a)
%5*10-3*c1-3*c1+1*c3 = 0 for re1
%3*c1-1*c2-1*c2-1*c2 = 0 for re2
%8*20+1*c2-1*c3-8*c3 = 0 for re3
%2*c5+1*c2+8*c3-11*c4 = 0 for re4
%3*c1 + 1*c2 - 2*c5 -2*c5 = 0 for re5

%b)
%Gauss - Jordan Elimination method
a_matrix = [-6 0 1 0 0 -50; 3 -3 0 0 0 0; 0 1 -9 0 0 -160; 0 1 8 -11 2 0; 3 1 0 0 -4 0];
result_matrix = rref(a_matrix);

result_vector = result_matrix(:,size(result_matrix,2));
c1 = result_vector(1,:);
c2 = result_vector(2,:);
c3 = result_vector(3,:);
c4 = result_vector(4,:);
c5 = result_vector(5,:);

%Successive over-relaxation method
omega = 1.5
c1 = 0;
c2 = 0;
c3 = 0;
%c4 = 0;
%c5 = 0;

%taking the fourth equation for tolerance checking
residual_0(1) = (107-(c2)-(c3))/6 - c1;
residual_0(2) = (36-(c1)+(2*c3))/9 - c2;
residual_0(3) = (121-(2*c1)+(c2))/(8) - c3;
%residual_0(4) = -119/6-(c1/6)+(c2/3)-(5*c3/6)+(2*c5/3)-2*c4;
%residual_0(5) = -21-c1-(c2/3)-(2*c3/3)+2*c5;

%calculating the temporary values to be sed for updation
c1_te = (107-(c2)-(c3))/6;
c2_te = (36-(c1_te)+(2*c3))/9;
c3_te = (121-(2*c1_te)+(c2_te))/(8);
%c4_te = ((-119/6-(c1_te/6)+(c2_te/3)-(5*c3_te/6)+(2*c5/3))/2;
%c5_te = ((-21-c1_te-(c2_te/3)-(2*c3_te/3)))/(-2);

%now updating the previous values using the values obtained so far
c1 = c1 + omega*(c1_te-c1);
c2 = c2 + omega*(c2_te-c2);
c3 = c3 + omega*(c3_te-c3);
%c4 = c4 + omega*(c4_te-c4);
%c5 = c5 + omega*(c5_te-c5);

residual(1) = (107-(c2)-(c3))/6 - c1;
residual(2) = (36-(c1_te)+(2*c3))/9 - c2;
residual(3) = (121-(2*c1_te)+(c2_te))/(8) - c3;
%residual(4) = -119/6-(c1/6)+(c2/3)-(5*c3/6)+(2*c5/3)-2*c4;
%residual(5) = -21-c1-(c2/3)-(2*c3/3)+2*c5;

%calculating the tolerance value
tol = norm(residual)/norm(residual_0);
counter = 1;
while (tol >= 1e-6 && counter <= 5)
    c1 = c1_te;
    c2 = c2_te;
    c3 = c3_te;

    c1_te = (107-(c2_te)-(c3_te))/6;
    c2_te = (36-(c1_te)+(2*c3_te))/9;
    c3_te = (121-(2*c1_te)+(c2_te))/(8);
    %c4_te = ((-119/6-(c1_te/6)+(c2_te/3)-(5*c3_te/6)+(2*c5/3))/2;
    %c5_te = ((-21-c1_te-(c2_te/3)-(2*c3_te/3)))/(-2);

    %now updating the previous values using the values obtained so far
    c1 = c1 + omega*(c1_te-c1)
    c2 = c2 + omega*(c2_te-c2)
    c3 = c3 + omega*(c3_te-c3)
    %c4 = c4 + omega*(c4_te-c4);
    %c5 = c5 + omega*(c5_te-c5);
    counter = counter + 1;

    %renewing the tolerance values
    residual_0 = residual;
    
    residual_0(1) = (107-(c2)-(c3))/6 - c1;
    residual_0(2) = (36-(c1_te)+(2*c3))/9 - c2;
    residual_0(3) = (121-(2*c1_te)+(c2_te))/(8) - c3;
    %residual(4) = -119/6-(c1/6)+(c2/3)-(5*c3/6)+(2*c5/3)-2*c4;
    %residual(5) = -21-c1-(c2/3)-(2*c3/3)+2*c5;
    tol = norm(residual)/norm(residual_0);
end
counter  %number of iterations obtained is 11.

%Gauss - Seidel Method
%based on previous result, we fix initial guess as c1 = c2 = c5 = 10, c3 =
%20, c4 = 15.

c1 = 0;
c2 = 0;
c3 = 0;

%taking the fourth equation for tolerance checking
f_old = 2*c1-c2+c3-3;

%updating the values as and when they are calculated
c1 = (3+c2-c3)/2
c2 = 6-c3-c1
c3 = (c1+c2+3)/3

f_new = 2*c1-c2+c3-3;

%calculating the tolerance value
tol = abs((f_new-f_old)/f_new);
counter = 1;
while (tol >= 1e-6 && counter <= 5)
    c1 = (3+c2-c3)/2
    c2 = 6-c3-c1
    c3 = (c1+c2+3)/3
    counter = counter + 1;

    %renewing the tolerance values
    f_old = f_new;
    f_new = 2*c1-c2+c3-3;
    tol = abs((f_new-f_old)/f_new);
end
counter  %number of iterations obtained is 11.

%jacobi iterative method
%based on previous result, we fix initial guess as c1 = c2 = c5 = 10, c3 =
%20, c4 = 15.

c1 = 0;
c2 = 0;
c3 = 0;


%taking the fourth equation for tolerance checking (for comparison with
%previous method also)
f_old = 2*c1-c2+c3-3;

%calculating the values first, and updating the values only after every
%value is found.
c1_t = (3+c2-c3)/2
c2_t = 6-c3-c1
c3_t = (c1+c2+3)/3


%updating values
c1 = c1_t;
c2 = c2_t;
c3 = c3_t;

f_new = 2*c1-c2+c3-3;
%calculating the tolerance value
tol = abs((f_new-f_old)/f_new);
counter = 1;
while (tol >= 1e-6 && counter <= 5)
    %calculating the values first, and updating the values only after every
    %value is found.
    c1_t = (3+c2-c3)/2
    c2_t = 6-c3-c1
    c3_t = (c1+c2+3)/3

    %updating values
    c1 = c1_t;
    c2 = c2_t;
    c3 = c3_t;
    counter = counter + 1;
    
    %renewing the tolerance values
    f_old = f_new;
    f_new = 2*c1-c2+c3-3;
    tol = abs((f_new-f_old)/f_new);
end
counter     %number of iterations obtained is 31, which is almost thrice than the previos case

%c)(check previous comments for iterations comments also)
%the solution obtained is nearly the same in each and every case, done so
%far. The only difference is the number of flops used for each numeric
%method, in which, Gauss - Seidel clearly wins.