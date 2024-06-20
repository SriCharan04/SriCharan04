true_value = 3 + 2 * exp(2);
initial_value = 3 + 2 * exp(0);
approximations = zeros(1, 6);  % Store the approximated values
percent_errors = zeros(1, 6);  % Store the percent relative errors
for n = 0:5
    approximation = initial_value + (2^n/factorial(n))*2;
    percent_error = abs(true_value - approximation) / true_value*100;
    approximations(n+1) = approximation;
    percent_errors(n+1) = percent_error;
    initial_value = approximation;
    fprintf('Order %f Approximation: %f, Percent Relative Error: %f%%\n', n, approximations(n+1), percent_errors(n+1));
end
