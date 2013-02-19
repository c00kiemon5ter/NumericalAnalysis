// Exercise D4
// -----------
// approximate the integral of f(x) = e^(2·x)·3·x in space [0,2]
// using simpson 1/3 and simpson 3/8 rules when the space is divided
// in n = [ 4, 8, 16, 32 ] subspaces
//
// each subspace is divided more so that both rules can be applied.
// that is, to apply the simpson 1/3 rule we need 2·n subspaces and
// to apply simpson 3/8 rules we need 3·n subspaces from each subspace.

function xi = x(x0, i, h)
xi = x0 + i * h
endfunction

function y = f(x)
y = %e^(2*x) * 3 * x
endfunction

function y = simpson13(f, a, b, n)
// composite simpson 1/3 rule: h = (b - a) / 2·n
// I[a,b]f(x)dx ~= h·1/3·(f(a) + 2·Sum[j=1,n/2-1]f(x_2j) + 4·Sum([j=1,n/2]f(x_2j-1) + f(b)
h = (b - a) / (2*n)
y = f(a) + f(b)
for j = 1 : 1 : n - 1
	y = y + 2 * f(x(a, 2*j, h))
end
for j = 1 : 1 : n
	y = y + 4 * f(x(a, 2*j - 1, h))
end
y = h/3 * y
endfunction

function y = simpson38(f, a, b, n)
// composite simpson 3/8 rule: h = (b - a) / 3·n
// I[a,b]f(x)dx ~= h·3/8·Sum[j=1,n](f(x_3j-3) + 3·f(x_3j-2) + 3·f(x_3j-1) + f(x_3j))
h = (b - a) / (3*n)
y = 0
for j = 1 : 1 : n
	y = y + f(x(a, 3*j - 3, h)) + 3*f(x(a, 3*j - 2, h)) + 3*f(x(a, 3*j - 1, h)) + f(x(a, 3*j, h))
end
y = h * 3/8 * y
endfunction

// ---------- ---------- main execution ---------- ----------

a = 0
b = 2

exact = 3/4 * (1 + 3 * %e^4)

tic() // or timer()

printf('\nsimpson 1/3 rule')
printf('\n----------------\n')
for n = [ 4 8 16 32 ]
	appr = simpson13(f, a, b, n)
	abs_err = abs(exact - appr)
	rel_err = abs(abs_err / exact)
	printf('result %f with relative %f and absolute %f error for n = %d\n', appr, rel_err, abs_err, n)
end

printf('timer is at %f\n', toc()) // or timer()

printf('\nsimpson 3/8 rule')
printf('\n----------------\n')
for n = [ 4 8 16 32 ]
	appr = simpson38(f, a, b, n)
	abs_err = abs(exact - appr)
	rel_err = abs(abs_err / exact)
	printf('result %f with relative %f and absolute %f error for n = %d\n', appr, rel_err, abs_err, n)
end

printf('timer is at %f\n', toc()) // or timer()

// Results and Commentary
// ----------------------
// Looking at the relative and absolute errors, the error seems to be one sixteenth
// of what it was on the previous round. As such we can roughly estimate the absolute
// error when n = 64.
// For simpson 1/3 rule, when n = 32 the absolute error is 0.000024
// the rough estimate for n = 64 would be 24/16 * 10^-6 = 0.0000015
// For simpson 3/8 rule, when n = 32 the absolute error is 0.000011
// the rough estimate for n = 64 would be 11/16 * 10^-6 = 0.0000006875
//
// Looking at the timer's timings, we can see that simpson 1/3 rule is about two
// times faster than simpson 3/8 rule, as the latter does more calculations.
//
// When asked for a 5 decimal digit accuracy one should chose simpson 1/3 rule, as
// it achieves that accuracy faster (about half the time) then simpson 3/8 rule
//
// Output:
// > simpson 1/3 rule
// > ----------------
// > result 123.690932 with relative 0.000769 and absolute 0.095094 error for n = 4
// > result 123.601951 with relative 0.000049 and absolute 0.006113 error for n = 8
// > result 123.596222 with relative 0.000003 and absolute 0.000385 error for n = 16
// > result 123.595862 with relative 0.000000 and absolute 0.000024 error for n = 32
// > timer is at 0.003000
// >
// > simpson 3/8 rule
// > ----------------
// > result 123.638280 with relative 0.000343 and absolute 0.042443 error for n = 4
// > result 123.598557 with relative 0.000022 and absolute 0.002720 error for n = 8
// > result 123.596009 with relative 0.000001 and absolute 0.000171 error for n = 16
// > result 123.595848 with relative 0.000000 and absolute 0.000011 error for n = 32
// > timer is at 0.006000

