// Exercise B13
// ------------
// Given the equation for ideal gas: P·V = n·R·T
// If the gas is not ideal the equation transforms to:
//   (P + (n^2·a)/(V^2))·(V - n·b) = n·R·T
//
// Given Facts:
// P = 20atm
// n = 1 mole
// R = 0.020578 L·atm·mol^−1·K^−1  or  8.314 J·K^−1·mol^−1
// T = 760K
// a = 18 lit^2·atm/mole
// b = 0.1154 lit/mole
//
// Wanted:
// approximate V using Secant method for 3 digit accuracy
// x_n = x_n-1 - f(x_n-1)·(x_n-1 - x_n-2) / (f(x_n-1) - f(x_n-2))
//
// Form of f(V):
// (P + (n^2·a)/(V^2))·(V - n·b) = n·R·T ==>
// (P + (n^2·a)/(V^2))·(V - n·b) - n·R·T = 0
// So, f(V) = (P + (n^2·a)/(V^2))·(V - n·b) - n·R·T

function y = f(V)
y = (P + (n^2*a)/(V^2))*(V - n*b) - n*R*T
endfunction

function y = newton(f, x)
// newton-raphson method: x_n+1 = x_n - f(x_n) / f'(x_n)
y = x - f(x) / derivative(f, x)
endfunction

function y = secant(f, x0, x1)
// secant method: x_n = x_n-1 - f(x_n-1) · (x_n-1 - x_n-2) / (f(x_n-1) - f(x_n-2))
y = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
endfunction

// ---------- ---------- main execution ---------- ----------

P = 20
n = 1
R = 0.020578
T = 760
a = 18
b = 0.1154

tol = 0.5 * 10^-3
loops = 60
loop  = 0

x0 = n * R * T / P
x1 = newton(f, x0)

// stop when the tolerance goal is reached
// a root is either found or has good enough approximation
while loop < loops & abs(f(x1)) > tol & abs(x1 - x0 / x1) > tol // & abs(x1 - x0) > tol
	loop = loop + 1
	x2 = secant(f, x0, x1)
	x0 = x1
	x1 = x2
end

if loop >= loops
	printf('exceeded loop limit: %d\n', loops)
end

printf('after %d loops\nroot: %f\nf(x): %f\n', loop, x1, f(x1))

// Results and Commentary
// ----------------------
// Output:
// > after 39 loops
// > root: 0.129761
// > f(x): -0.000022

