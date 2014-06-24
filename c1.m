%
% we try to approximate gamma function using 
% an interpolation polynomial. We calculate 
% the latter using the using cubic splines and 
% Newton-Gregorey forward differences. In the end
% we plot the gamma along with the calculated polynomial 
%
function [] = c1()
%the given points we want to interpolate
xi = [1, 2, 3, 4, 5];
fi = [1, 1, 2, 6, 24];

splines_interpolation(xi, fi);
forward_NG(xi, fi);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%natural cubic splines interpolation implementation
%get the xi ,along with fi, values we want to interpolate
function [] = splines_interpolation(xi, fi)

%get the xi points distances(hi) check get_hi function for more info
hi = get_hi(xi);

xi_length = length(xi);
A = zeros(xi_length);
b = zeros(xi_length, 1);

%by default in natural cubic splines the A(1,1) is 1
A(1,1) = 1;

%we want to solve Ac=b for splines
%first we compute the A array
for i = 2:xi_length-1
   A(i,i-1) = hi(i-1);
   A(i,i) = 2*(hi(i-1)+hi(i));
   A(i,i+1) = hi(i);
end

%also this value of A is fixed by default in splines
A(xi_length, xi_length) = 1;

%then we compute b
for i = 2:xi_length-1
    b(i) = (3/hi(i))*(fi(i+1)-fi(i))-(3/hi(i-1))*(fi(i)-fi(i-1));
end

%having now the A and b matrixes we solve the Ac=b to find all ci values 
ci = A\b;

%now initialize the rest 
%of the missing variables (ai, bi, di)
ai = fi;
[di, bi] = deal(zeros(xi_length-1, 1));

%calculate the di values using ci
for i = 1:xi_length-1
    di(i) = (1/(3*hi(i)))*(ci(i+1)-ci(i));
end

%calculate bi using ai and ci
for i = 1:xi_length-1
   bi(i) = (1/hi(i))*(ai(i+1)-ai(i)) - (hi(i)/3)*(2*ci(i)+ci(i+1)); 
end

%here we will save the Si(splines) polynomials
Si = sym(zeros(xi_length-1, 1));

syms x;

%keep the figure on in order to plot all splines and the gamma function
%in the end
hold on

%set the x axis limits
xlim([xi(1), xi(end)]);

for i = 1:xi_length-1;
    %calculate the Si polynomials
    Si(i) = ai(i) + bi(i)*(x-xi(i)) + ci(i)*(x-xi(i))^2 + di(i)*(x-xi(i))^3;
    
    %plot current spline , keep the figure on
    ez = ezplot(Si(i), [xi(i), xi(i+1)]);
end

%finally plot the gamma function on top of our splines
g = ezplot(gamma(x), [xi(1), xi(end)]);
%we use red color for gamma function
set(g, 'Color', 'red');
%mark the interpolation xi points
plot(fi, 'o');
%set legend for out plot
leg = legend([ez, g],'splines','gamma');
%change the location of the legend
set(leg,'Location','NorthWest');
hold off

end

%gets an array of xi points we want to interpolate and calculates all the hi
%distances between the xi points, it is needed for the splines
%interpolation
function hi = get_hi(xi)
    xi_length = length(xi);
    hi = zeros(xi_length-1, 1);
    
    for i = 1:xi_length-1
        %for example h0 = x1 - x0
        hi(i) = xi(i+1) - xi(i);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%forward diffs Newton-Gregorey implementation, 
%gets xi and fi we want to interpolate
function [] = forward_NG(x_values, f_values)
%assuming the x points have the same distance between them 
%(in order for the NG to work) we get the h:
%h = x1 - x0
h = x_values(2) - x_values(1);

syms x;
%theta = (x - x0)/ h
theta = ( x - x_values(1) ) / h;

%the the forward diffs, check the func for more info
forward_diffs = get_forward_diffs(x_values, f_values);

%interpolation polynomial
P_temp = forward_diffs(1);

%we construct step by step  interpolation polynomial using the 
%forward diffs we have and the thetas
for i = 1:length(x_values)-1
    P_temp = P_temp + get_theta(i)*forward_diffs(i+1);
end

%finally we substitute the P with the real value of theta 
%(where theta = (x - x0) /h)
P = subs(P_temp, theta);

%here plot our interpolation polynomial
%together with the matlab's gamma function

%create a new figure (existing figure should contain splines)
figure
hold on
ez = ezplot(P, [1,5]);

g = ezplot(gamma(x), [1,5]);
set(g, 'Color', 'red');
leg = legend([ez, g],'NG interpolation', 'gamma');
set(leg,'Location','NorthWest');

plot(f_values, 'o');

hold off

end

%get theta (theta 0) or (theta 1) etc
function theta = get_theta(n)
    syms th;
    
    %first we calculate the enumerator
    theta = th;
    for i = 1:n-1
        theta = theta * ( th -i);
    end
    
    %here we calculate the denominator
    theta   = theta / factorial(n);
end

%forward diff implementation
function [forward_diffs] = get_forward_diffs(xi, fi)
    xi_length = length(xi);
    
    %initialize the array of x_values size
    forward_diffs = zeros(xi_length,1);
    forward_diffs(1) = fi(1);
    di = fi;
    
    for i = 1:xi_length-1
        di_pre = di;
        di = zeros(xi_length-i, 1);
        for j = 1:xi_length-i
            di(j) = di_pre(j+1) - di_pre(j);
        end
        forward_diffs(i+1) = di(1);
    end

end
