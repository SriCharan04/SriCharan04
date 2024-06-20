%Successive over-relaxation method
omega = 1.5;
c(1) = 0;   
c(2) = 0;
c(3) = 0;
c(4) = 0;
c(5) = 0;

%taking the fourth equation for tolerance checking
residual_0(1) = 1-(c(2)/2)-(c(3)/4)-(c(4)/8)-(c(5)/12)-c(1);
residual_0(2) = -13/6-(c(1)/2)-(c(3)/3)-(c(4)/4)-(c(5)/6)-(2*c(2));
residual_0(3) = 19/3-(c(1)/3)-c(2)-(2*c(4)/3)-c(5) + 3*c(3);
residual_0(4) = -119/6-(c(1)/6)+(c(2)/3)-(5*c(3)/6)+(2*c(5)/3)-2*c(4);
residual_0(5) = -21-c(1)-(c(2)/3)-(2*c(3)/3)+2*c(5);
initial_norm = norm(residual_0);
initial_norm

%calculating the temporary values to be sed for updation
c_te(1) = 1-(c(2)/2)-(c(3)/4)-(c(4)/8)-(c(5)/12);
c_te(2) = (-13/6-(c_te(1)/2)-(c(3)/3)-(c(4)/4)-(c(5)/6))/2;
c_te(3) = (19/3-(c_te(1)/3)-c_te(2)-(2*c(4)/3)-c(5))/(-3);
c_te(4) = (-119/6-(c_te(1)/6)+(c_te(2)/3)-(5*c_te(3)/6)+(2*c(5)/3))/2;
c_te(5) = ((-21-c_te(1)-(c_te(2)/3)-(2*c_te(3)/3)))/(-2);

%now updating the previous values using the values obtained so far
c_new(1) = c(1) + omega*(c_te(1)-c(1));
c_new(2) = c(2) + omega*(c_te(2)-c(2));
c_new(3) = c(3) + omega*(c_te(3)-c(3));
c_new(4) = c(4) + omega*(c_te(4)-c(4));
c_new(5) = c(5) + omega*(c_te(5)-c(5));
c_new

residual(1) = 1-(c_new(2)/2)-(c_new(3)/4)-(c_new(4)/8)-(c_new(5)/12)-c_new(1);
residual(2) = -13/6-(c_new(1)/2)-(c_new(3)/3)-(c_new(4)/4)-(c_new(5)/6)-(2*c_new(2));
residual(3) = 19/3-(c_new(1)/3)-c_new(2)-(2*c_new(4)/3)-c_new(5) + 3*c_new(3);
residual(4) = -119/6-(c_new(1)/6)+(c_new(2)/3)-(5*c_new(3)/6)+(2*c_new(5)/3)-2*c_new(4);
residual(5) = -21-c_new(1)-(c_new(2)/3)-(2*c_new(3)/3)+2*c_new(5);
residual
norm(residual)
0
%calculating the tolerance value
tol = norm(residual)/norm(residual_0);
counter = 1;
while (tol >= 1e-6 && counter <= 10)
    c = c_new;

    c_te(1) = 1-(c(2)/2)-(c(3)/4)-(c(4)/8)-(c(5)/12);
    c_te(2) = (-13/6-(c_te(1)/2)-(c(3)/3)-(c(4)/4)-(c(5)/6))/2;
    c_te(3) = (19/3-(c_te(1)/3)-c_te(2)-(2*c(4)/3)-c(5))/(-3);
    c_te(4) = (-119/6-(c_te(1)/6)+(c_te(2)/3)-(5*c_te(3)/6)+(2*c(5)/3))/2;
    c_te(5) = ((-21-c_te(1)-(c_te(2)/3)-(2*c_te(3)/3)))/(-2)

    
    %now updating the previous values using the values obtained so far
    c_new(1) = c(1) + omega*(c_te(1)-c(1));
    c_new(2) = c(2) + omega*(c_te(2)-c(2));
    c_new(3) = c(3) + omega*(c_te(3)-c(3));
    c_new(4) = c(4) + omega*(c_te(4)-c(4));
    c_new(5) = c(5) + omega*(c_te(5)-c(5));
    c_new

    counter = counter + 1;
    %renewing the tolerance values
    residual_0 = residual;
    
    residual(1) = 1-(c_new(2)/2)-(c_new(3)/4)-(c_new(4)/8)-(c_new(5)/12)-c_new(1);
    residual(2) = -13/6-(c_new(1)/2)-(c_new(3)/3)-(c_new(4)/4)-(c_new(5)/6)-(2*c_new(2));
    residual(3) = 19/3-(c_new(1)/3)-c_new(2)-(2*c_new(4)/3)-c_new(5) + 3*c_new(3);
    residual(4) = -119/6-(c_new(1)/6)+(c_new(2)/3)-(5*c_new(3)/6)+(2*c_new(5)/3)-2*c_new(4);
    residual(5) = -21-c_new(1)-(c_new(2)/3)-(2*c_new(3)/3)+2*c_new(5);
    norm(residual)
    residual
    tol = norm(residual)/initial_norm;
end
counter  %number of iterations obtained is 11.
