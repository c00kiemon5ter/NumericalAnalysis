%
% implement Newton-Raphson to approximate a^(1/m)
% we apply the method for a = 2, 3 and m = 3, 4, 5, 6, 7, 8
%
function [] = b8()
format long;

%will be used each time to approximate
%the x = a^(1/m), it is like we are using 
%g(x) = x^m +x -a, where f(x) = g(x) - x
f = @(x, m, a) x^m -a;
syms z;

%maximum loops of Newton-Raphson,
%(in order to avoid infinite loop in case of error)
max_loops = 60;

%the accuracy we want in approximation
tol = 0.5*10^-6;

%here are the values for which we will test
%our approximations
a_values = [ 2, 3 ];
m_values = [ 3, 4, 5, 6, 7, 8 ];

%most of our x actual values are:
% 1 < x < 1.5, so we start to approximate 
%in all the cases from x0 = 0.5 
%(this came up after testing, also works with other values)
x0 = 0.5;

for a = a_values
    for m = m_values
        loop = 0;
        
        fprintf('Approximating %d^(1/%d)\n', a, m);
        
        %Newton-Raphson method
        while loop < max_loops
            loop = loop + 1;

            %with syms z and diff we calculate the derivative of our
            %function and then with subs we substitute z with x to
            %calcutate the value of the derivative
            x1 = x0 - f(x0,m,a) / subs(diff(f(z,m,a)), x0);

            %once we get the desired accuracy in approximation, print the
            %results and break out of the loop
            if abs( x1 - x0 ) < tol
                fprintf('Actual value: %f\n', a^(1/m));
                fprintf('Approximated value: %f\n\n', x1);
                break;
            end

            x0 = x1;
        end
        
    end
end

end