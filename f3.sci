// Exercise F3
// -----------
// Given:
//   y(0) = 1/3,
//   y' = -5·y + 5·x^2 + 2·x  ,  0 <= x <= 2
//
// approximate y(2) with
//   Euler's method with h = 0.025
//   Midpoint method with h = 0.05
//   RK4 methode with h = 0.1
//
// the exact solution is: y(x) = x^2 + 1/3·e^(-5·x)
//
// Which method was more accurate ?
// Plot the exact solution with the approximations.

function e = abs_err(exact, approx)
e = abs(exact - approx)
endfunction

function e = rel_err(exact, approx)
e = abs(abs_err(exact, approx) / exact)
endfunction

function y = exact(x)
y = x^2 + 1/3 * %e^(-5*x)
endfunction

function y = f(t, y)
y = -5 * y + 5 * t^2 + 2 * t
endfunction

function [t, y] = euler(f, t0, y0, h, tn)
// Eulers method: y_n+1 = y_n + h·f(t_n, y_n)
n = (tn - t0) / h
t(1) = t0
y(1) = y0
for i = 1 : 1 : n
	t(i+1) = t(i) + h
	y(i+1) = y(i) + h * f(t(i), y(i))
end
endfunction

function [t, y] = midpoint(f, t0, y0, h, tn)
// Midpoint method: y_n+1 = y_n + h·f(t_n + h/2, y_n + h/2·f(t_n, y_n))
n = (tn - t0) / h
t(1) = t0
y(1) = y0
for i = 1 : 1 : n
	t(i+1) = t(i) + h
	y(i+1) = y(i) + h * f(t(i) + h/2, y(i) + h/2 * f(t(i), y(i)))
end
endfunction

function [t, y] = rk4(f, t0, y0, h, tn)
// RK4 method: y_n+1 = y_n + 1/6·(k1 + 2·k2 + 2·k3 + k4)
// k1 = h·f(t_n      , y_n)
// k2 = h·f(t_n + h/2, y_n + k1/2)
// k3 = h·f(t_n + h/2, y_n + k2/2)
// k4 = h·f(t_n + h  , y_n + k3)
n = (tn - t0) / h
t(1) = t0
y(1) = y0
for i = 1 : 1 : n
	t(i+1) = t(i) + h
	k1 = h * f(t(i)      , y(i))
	k2 = h * f(t(i) + h/2, y(i) + k1/2)
	k3 = h * f(t(i) + h/2, y(i) + k2/2)
	k4 = h * f(t(i) + h  , y(i) + k3)
	y(i+1) = y(i) + 1/6 * (k1 + 2 * k2 + 2 * k3 + k4)
end
endfunction

// ---------- ---------- main execution ---------- ----------

y0 = 1/3
t0 = 0
tn = 2

v = exact(tn)
printf('exact value is %f\n', v)

printf('\nEuler method')
printf('\n------------\n')
[t, y] = euler(f, t0, y0, 0.025, tn)
printf('y(%f) = %f\n', t($), y($))
printf('absolute error %f\n', abs_err(v, y($)))
printf('relative error %f\n', rel_err(v, y($)))

plot(t, y, 'r')

printf('\nMidpoint method')
printf('\n---------------\n')
[t, y] = midpoint(f, t0, y0, 0.05, tn)
printf('y(%f) = %f\n', t($), y($))
printf('absolute error %f\n', abs_err(v, y($)))
printf('relative error %f\n', rel_err(v, y($)))

plot(t, y, 'g')

printf('\nRK4 method')
printf('\n----------\n')
[t, y] = rk4(f, t0, y0, 0.1, tn)
printf('y(%f) = %f\n', t($), y($))
printf('absolute error %f\n', abs_err(v, y($)))
printf('relative error %f\n', rel_err(v, y($)))

plot(t, y, 'b')

// Results and Commentary
// ----------------------
// NOTE: implementations use n+1, as index 0 is invalid
// so, t0 is t(1), t1 is t(2), ..., tn is t(n+1)
//
// From the three methods, RK4 is the most accurate.
//
// Output:
// > exact value is 4.000015
// >
// > Euler method
// > ------------
// > y(2.000000) = 3.995008
// > absolute error 0.005007
// > relative error 0.001252
// >
// > Midpoint method
// > ---------------
// > y(2.000000) = 4.000731
// > absolute error 0.000716
// > relative error 0.000179
// >
// > RK4 method
// > ----------
// > y(2.000000) = 4.000081
// > absolute error 0.000066
// > relative error 0.000017

