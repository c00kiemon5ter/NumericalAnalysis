% 
% This program calculates approximately the derivative 
% of a given function using: f'(x) = f(x+h)-f(x)/ h
%
% In this example we approximate sin(x) for x = 1
%
% We plot the relative absolute errors versus h where
% h = 1/2^k for k = 1, 2, ..., 50. we use log scale for h
%
function [] = a14()
    format long;
    
    %range for all k possible values
    MIN = 1;
    MAX = 50;
    x = 1;
    hs = zeros(MAX,1);
    rel_errors = zeros(MAX,1);
    
    %the function to approach
    f = @(x) sin(x);
    
    %h depends each time in k values (MIN, MAX range)
    h = @(k) 1 / (2^k);
    
    %here the function we use to approximate the derivative of
    %a function f
    approx_derivative = @(f, x, h) (f(x + h) - f(x)) / h;
    
    %we use symbolic value z in order to 
    %calculate the actual derivative value
    syms z;
    %with diff we symbolically find the derivative and with subs we
    %substitute the syms z with the actual x we need to calculate
    actual_der = subs(diff( f(z) ), x);
    
    for k = MIN : MAX
        %calculate the h value and save it for later plot
        h_value = h(k);
        hs(k) = h_value;
        
        %here we calculate the relative error and we save into the
        %rel_errors to plot it later
        rel_errors(k) = abs( (approx_derivative(f, x, h_value) - actual_der) / actual_der);
    end
    
    %find the minimum relative error
    [min_err, h_index] = min(rel_errors);
    
    fprintf('Minimum relative error: %.14f , for k: %d and h: %.14f \n', min_err, h_index, hs(h_index));
    
    loglog(hs, rel_errors);
    ylabel('approximation relative error (logscale)');
    xlabel('h (logscale)');
end
