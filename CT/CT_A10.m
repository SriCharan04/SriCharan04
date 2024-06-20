%Task 2
t = [0, 5, 10, 15, 20];
temp = [75, 68, 61, 54, 47];

%value obtained by linear interpolation
y = lin_interp(7.5,t(2),t(3),temp(2),temp(3))
z = quad_interp(12.5,t(5),t(4),t(3),temp(5),temp(4),temp(3))

function y = lin_interp(t,t1,t0,temp_1,temp_0)
    y = temp_0 + ((temp_1-temp_0)/(t1-t0))*(t-t0);
end
    
function z = quad_interp(t,t2,t1,t0,temp_2,temp_1,temp_0)
    fd2 = (temp_2-temp_1)/(t2-t1);
    fd1 = (temp_1-temp_0)/(t1-t0);
    
    z = temp_0 + fd1*(t-t0) + ((fd2-fd1)/(t2-t0))*(t-t0)*(t-t1);
end

%Linear interpolation is relatively simple to implement, and requires
%lesser number of datapoints to arrive at a result, compared to quadratic
%interpolation
%Also, as it requires lesser nmber of points, it is computationally
%efficient, than quadratic interpolation.

%I would prefer 
%i)Linear interpolation when, the underlying physics of the model tell the
%behaviour is linear, when the model has relatively high error/noise in it
%or when there are relatively larger number of points to be computed for.

%ii)Quadratic interpolation when, the underlying physics of the model
%suggests complexity greater than linearity, when the model is trusted to
%be of lesser error, and when there are lesser number of points to be
%computed for.