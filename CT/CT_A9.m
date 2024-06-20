%Task1
%with 10 grids
I_1 = trapezoidal(@cube,0,1,100)

%with 100 grids
I_2 = trapezoidal(@cube,0,1,100)

%Actual integral value
J = anal_int(@cube,0,1)
%as we can see, as the number of grids increases, the closeness to the
%actual value, increases

K = simpson_13(@cube,0,1,100)

%Task2
gridpoints = 11;
midpoint = (gridpoints+1)/2;
[generated_array,grid_l] = gen_array(@cube,0,1,gridpoints);
slope = differe(@second_central,generated_array,midpoint,grid_l);

%Actual kinetic experiment simulation
time_arr = linspace(0,10,100);
grid_length = 0.1;
[y_array,conc] = exper_res(time_arr);

figure;
plot(conc,y_array)
%finding the slope of each point to the maximum accuracy
size(y_array,2)
for i = 1:size(y_array,2)
    switch i
        case 1
        slope_array(i) = differe(@second_forward,y_array,i,grid_length);
    
        case size(y_array,2)
        slope_array(i) = differe(@second_backward,y_array,i,grid_length);
    
        case {2,3,size(y_array,2)-1,size(y_array,2)-2}
        slope_array(i) = differe(@first_central,y_array,i,grid_length);

        otherwise
        slope_array(i) = differe(@second_central,y_array,i,grid_length);
    end
end


%Task 1
function int_value = trapezoidal(f,low_l,high_l,grids)
    x_array = linspace(low_l,high_l,grids);
    y_array = f(x_array);
    zero_arr = [0];
    temp_1 = {zero_arr,y_array};
    cat_array_1 = cat(2,temp_1{:});
    temp_2 = {y_array,zero_arr};
    cat_array_2 = cat(2,temp_2{:});

    sum_array = (cat_array_1 + cat_array_2);
    sum_array = sum_array(2:end-1);
    sum_of_array = sum(sum_array);
    int_value = (high_l-low_l)*sum_of_array/(2*grids);
end

function int_value = simpson_13(f,low_l,high_l,grids)
    x_array = linspace(low_l,high_l,grids);
    y_array = f(x_array);
    sum = 0;
    for i = 1:size(y_array,2)
        if (i == 1) 
            sum = sum + y_array(i);
        end

        if (i == size(y_array)) 
            sum = sum + y_array(i);
            break
        end
        
        j = mod(i,3)
        switch j    
            case 1
                sum = sum + 4*y_array(i);
            
            case 2
                sum = sum + 2*y_array(i);
        end
    end
    sum;
    int_value = (high_l-low_l)*sum/(2*grids);
end 

function y = cube(x)
    y = x.*x.*x;
end

function y = cos(x)
    y = cos(x);
end
  
function y = exponential(x)
    y = exp(x);
end

function I = anal_int(f,low_l,high_l)
    I = integral(f,low_l,high_l);
end
    
%Task 2
function [generated_array,grid_length] = gen_array(funct,low_l,high_l,gridpoints) 
    x_array = linspace(low_l,high_l,gridpoints);
    generated_array = funct(x_array);
    grid_length = (high_l-low_l)/gridpoints;
end

function slope = differe(accuracy,generated_array,point,grid_length)
    slope = accuracy(generated_array,point,grid_length);
end

function derivative = first_central(generated_array,point,width)
    derivative = (generated_array(point+1)-generated_array(point-1))/(2*width);
end
   
function derivative = second_central(generated_array,point,width)
    derivative = (-generated_array(point+3)+3*generated_array(point+1)-3*generated_array(point-1)+generated_array(point-3))/(width*width);
end

function derivative = second_forward(generated_array,point,width)
    derivative = (-3*generated_array(point)+4*generated_array(point+1)-generated_array(point+2))/(2*width);
end

function derivative = second_backward(generated_array,point,width)
    derivative = (3*generated_array(point)-4*generated_array(point-1)+generated_array(point-2))/(2*width);
end


%Task 3
function [y_array,desired_array] = exper_res(t_array)
    rng("twister")
    C_0 = 10;
    err_percent = 0.05;
    k = 0.4;
    desired_array = C_0.*exp(-k.*t_array);
    for i = 1:size(desired_array,2)
        r = 2*rand(1,1)-1;    
        y_array(i) = desired_array(i)*(1-(err_percent*r));
    end
end

