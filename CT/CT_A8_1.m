%Successive over-relaxation method
%definition of error is defined to be the ratio of the norms of the
%residual vector at a iteration and the initial residual vector

%the void value being 1, means that the program exited normally, with a
%plot of error v/s iterations

%defining the tolerance value, according to the given question
tolerance =  0.05;

%Q1
%MAIN CODE
c1 = SOR(1,tolerance)       %gives 3 iterations     %Gauss-Seidel
c2 = SOR(0.95,tolerance)    %gives 3 iterations     %Under-Relaxation
void = graph_with_relaxation_factor(0.3,1.7,tolerance);  %beyond omega = 1.7, the number of iterations exceed 100's

%OBSERVATIONS INCOMING
%as we can see, for omega array, centered at 1, we have a sudden iteration
%peak, at the RHS (omega in range [1,2]), whereas the LHS, is still
%relatively much flater.

%This may be because its extrapolating the solution vector, from the previous solution (closer to
%actual solution, and Gauss-Seidel value(also close to actual solution),
%and so, the next solution vector is in one of two directions, out of the
%line segment joining these two points, and that direction turns out to be
%closer to actual solution

%I guess that the system of equations, already have diagonal dominance, have some optimal value of omega in over-relaxation method such
%that it gives solutions faster, and also, in less number of iterations, which is the case with omega = [1,1.1].

%Also, the convergence in under-relaxation is predicted, to be less spiky,
%as its designed to converge non-diagonally dominant matrices.  But, it may take more time, than SOR. 

%FINALLY, OVERRELAXATION WORKS BETTER THAN UNDERRELAXATION IN THIS CASE

%FUNCTIONS INCOMING
%function to find the counters, corresponding to the omega values
function counter = SOR(omega,tolerance)
    %initialising the c vector with guess values
    c(1) = 0;
    c(2) = 0;
    c(3) = 0;
    
    %calculating the initial residual vector
    residual_0(1) = 44-15*c(3)-c(2)+3*c(1);
    residual_0(2) = 5-6*c(1)+2*c(2)-c(3);
    residual_0(3) = 28-5*c(1)-10*c(2)-c(3);
    initial_norm = norm(residual_0);

    %calculating the temporary Gauss-Seidel values 
    c_te(1) = (5+2*c(2)-c(3))/6;
    c_te(2) = (28-5*c(1)-c(3))/10;
    c_te(3) = (44-c(2)+3*c(1))/15;

    %now obtaining the next set of x's from Gauss-Seidel values, and previous
    %x values
    c_new(1) = c(1) + omega.*(c_te(1)-c(1));
    c_new(2) = c(2) + omega.*(c_te(2)-c(2));
    c_new(3) = c(3) + omega.*(c_te(3)-c(3));
    c_new;

    %calculating the new residual vector
    residual(1) = 44-15*c_new(3)-c_new(2)+3*c_new(1);
    residual(2) = 5-6*c_new(1)+2*c_new(2)-c_new(3);
    residual(3) = 28-5*c_new(1)-10*c_new(2)-c(3);

    %calculating the tolerance value
    tol = norm(residual)/initial_norm;

    %first iteration done
    counter = 1;

    %using the while loop to converge to the actual solution, using tolerance
    while (tol >= tolerance)
        %updating the c vector to be the previously obtained values
        c = c_new;

        %calculating the new set of Gauss-Seidel values
        c_te(1) = (5+2*c(2)-c(3))/6;
        c_te(2) = (28-5*c(1)-c(3))/10;
        c_te(3) = (44-c(2)+3*c(1))/15;

        %now obtaining the new c vector using previous c vector and
        %Gauss-Seidel values
        c_new(1) = c(1) + omega*(c_te(1)-c(1));
        c_new(2) = c(2) + omega*(c_te(2)-c(2));
        c_new(3) = c(3) + omega*(c_te(3)-c(3));

       %incrementing the counter for 1 iteration being done
       counter = counter + 1;

        %updating the old residual vector
        residual_0 = residual;
  
        %calculating the new residual vector
        residual(1) = 44-15*c_new(3)-c_new(2)+3*c_new(1);
        residual(2) = 5-6*c_new(1)+2*c_new(2)-c_new(3);
        residual(3) = 28-5*c_new(1)-10*c_new(2)-c(3);
   
        %renewing the tolerance values
        tol = norm(residual)/initial_norm;
    end
end    

%function to plot the counters with omega values
function void = graph_with_relaxation_factor(w_start,w_end,tolerance)
    %obtaining a omega array, with 100 points, with given start and end
    %values
    w_array = linspace(w_start,w_end,1000);   %default of 100 points are used for plotting
    
    %evaluating the counters corresponding to the omega values
    for i = 1:1000
        counter(i) = SOR(w_array(i),tolerance);
    end

    %plotting the obtained results
    figure;
    plot(w_array,counter)
    
    %updating the exit flag
    void = 1;
end