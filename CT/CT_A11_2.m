clc;
clear;

%Task 3
%h = 1
b = [240 0 0 0 0 0 0 0 0 0 150];
t = [0 1 2 3 4 5 6 7 8 9 10];
A = [1 0 0 0 0 0 0 0 0 0 0; 1 -2.25 1 0 0 0 0 0 0 0 0; 0 1 -2.25 1 0 0 0 0 0 0 0; 0 0 1 -2.25 1 0 0 0 0 0 0; 0 0 0 1 -2.25 1 0 0 0 0 0; 0 0 0 0 1 -2.25 1 0 0 0 0; 0 0 0 0 0 1 -2.25 1 0 0 0; 0 0 0 0 0 0 1 -2.25 1 0 0; 0 0 0 0 0 0 0 1 -2.25 1 0; 0 0 0 0 0 0 0 0 1 -2.25 1;0 0 0 0 0 0 0 0 0 0 1];
T = inv(A) * transpose(b)

%h = 2
b_p = [240 0 0 0 0 150];
t_p = [0 2 4 6 8 10];
A_p = [1 0 0 0 0 0; 1 -2.6 1 0 0 0; 0 1 -2.6 1 0 0; 0 0 1 -2.6 1 0; 0 0 0 1 -2.6 1; 0 0 0 0 0 1];
T_p = inv(A_p) * transpose(b_p)

figure;
plot(t,T,'b--o',t_p,T_p,'g--o')

%we can observe that the solution with more points (h = 1), bulged more towards the
%bottom, and is also more smoother than the one with lesser number of
%points (h = 2). Hence, we can say that the actual solution would more
%likely, be bulged down also.