%
% Euler implementation to solve the functions in the end of this file
% we use h = 1/2, 1/4, 1/8, 1/16
%
function [] = f12()
    hi = [ 1/2, 1/4, 1/8, 1/16 ];
    % common t range for all functions
    t_range = [ 0, 2 ];
    
    %here we save all the function as handles so we call them
    %into a loop using an index
    fi = { @f1, @f2, @f3, @f4, @f5 };
    %here are the corresponding y0 values for each f function
    y0_values = [ 0.5, -2, 1/3, 1, 1 ];
    fi_orig = { @f1_orig, @f2_orig, @f3_orig, @f4_orig, @f5_orig };
    
    %test all the functions
    fprintf('REuler goes for the Richardson-Euler method\n\n')
    for i = 1:length(fi)
        fprintf('############ FUNC %d ###########\n', i)
        exact_value = fi_orig{i}(t_range(end));
        
        for h = hi
            fprintf('- - - - - - - - - - - - - - - - - - -');
            % call Euler
            e = euler(fi{i}, t_range(1), y0_values(i), h, t_range(end));
            fprintf('\nEuler: %f \th:%f\n', e(end), h );
            fprintf('Error: %f\n\n', abs((e(end)-exact_value)/exact_value));
            
            %call Richardson-Euler
            r = richardson_euler(fi{i}, t_range(1), y0_values(i), h, t_range(end));
            fprintf('REuler: %f\n', r(end) );
            fprintf('Error: %f\n\n', abs((r(end)-exact_value)/exact_value));
        end
        fprintf('\nExact: %f\n\n', exact_value);
    end
    

end

%Eulers method implementation
function y = euler(f, t0, y0, h, tn)
n = (tn-t0)/h;

[t, y] = deal(zeros(n, 1));

% the initial t0 and y0 values
t(1) = t0;
y(1) = y0;

for i = 1:n
    t(i+1) = t(i) + h;
    %Euler: y_n+1 = y_n + h·f(t_n, y_n)
    y(i+1) = y(i) + h * f(t(i), y(i));
end
 
end

%Richardson-Euler implementation
function y = richardson_euler(f, t0, y0, h, tn)
n = (tn-t0)/h;

[t, y] = deal(zeros(n, 1));

t(1) = t0;
y(1) = y0;

for i = 1:n
    t(i+1) = t(i) + h;
    %we use simple euler here with h/2
    y_temp = y(i) + (h/2)*f(t(i), y(i));
    
    %then apply the euler-richardson
    y(i+1) = y(i) + h * f(t(i)+(h/2), y_temp);
end
 
end

%%% functions to approach from here
%%% along with the actual y function to
%%% to calculate the error, 
%%% where given from the exercise description

%%%%%%%%%%%%%%%%%%%%%    1
function y = f1(t, x)
    y = x - t^2 + 1;
end

%orig goes for original function
function y = f1_orig(x)
    %exp(x) : e^2
    y = x^2 + 2*x - 0.5*exp(x) +1;
end

%%%%%%%%%%%%%%%%%%%%%    2
function y = f2(t, x)
    y = - (x + 1)*(x + 3);
end

function y = f2_orig(x)
    %exp(x) : e^2
    y = -3 + ( 2 / ( 1 + exp(-2*x) ) );
end

%%%%%%%%%%%%%%%%%%%%%    3
function y = f3(t, x)
    y = -5*x + 5*t^2 + 2*t;
end

function y = f3_orig(x)
    %exp(x) : e^2
    y = x^2 + (1/3)*exp(-5*x);
end


%%%%%%%%%%%%%%%%%%%%%    4
function y = f4(t, x)
    y = (2 - 2*t*x) / (x^2 + 1) ;
end

function y = f4_orig(x)
    %exp(x) : e^2
    y = (2*x + 1) / (x^2 + 1);
end

%%%%%%%%%%%%%%%%%%%%%    5
function y = f5(t, x)
    y = 1 + t + x;
end

function y = f5_orig(x)
    %exp(x) : e^2
    y = -2 + 3*exp(x) -x;
end


