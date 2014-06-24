%
% We implement 3/8 Simpson to approximate the intergral of:
%  y = 1 / sqrt(1 - ( xi^2 * sin(x).^2 ));  
% for a = 0 and b = pi/2 bounds.
%   we calculate and plot the integral for various values of xi
%  xi = i* 0.05, i=0,1,...,20
%
function [] = d9()
format long;

% a,b upper and lower values of the integral
a = 0;
b = pi/2;

%number of loops to perform/different values for i
set_num = 20;

%n number of the compartments to use in Simpson3/8
n = 20;

%initialize the matrixes to store the values we want to plot
[x_ax, y_ax] = deal(zeros(set_num, 1));

for i = 1:set_num
    xi = i* 0.05;
    integral_approx = Simpson38(a, b, n, xi);
    
    %save the values to plot
    x_ax(i) = xi;
    y_ax(i) = integral_approx;
end

%plot the our integrals
plot(x_ax,y_ax,'o');
ylabel('approximated integral (3/8Simpson)');
xlabel('x = i*0.05 (i = 0,1,...,20)');

end

% a,b upper and lower limits of the integral and n the compartments
function intergral = Simpson38(a,b,n,xi) 
    %n should contain 3K consecutive compartments. n must be an even number
    if mod(n,3) ~= 0
        % if it's not then increase it by one
        n = n + (3 - mod(n,3));
    end
    
    % set the step h
    h = (b-a)/n;
    
    %initial values
    x = a;
    sum_fi = 0;

     %make a loop and construct the main sum of Simpson38 with all xi values
    for i=1:n-1 
        %get the next xi
        x = x + h;  
        if mod(i,3) == 0 
            sum_fi = sum_fi + (2 * f(xi, x)); 
        else
            sum_fi = sum_fi + (3 * f(xi, x)); 
        end
    end
    
    %construct the final Simpson38 sum 
    intergral = ((3*h)/8) * (f(xi, a) + sum_fi + f(xi, b));
    
    %was used for test
    %matlab_integral(a, b, xi)
end

%this is the function we want to calculate the intergral
function y = f(xi, x)
    y = 1 / sqrt(1 - ( xi^2 * sin(x).^2 ));
end
    