// Exercise A19
// ------------
// Find the relative and absolute error of
// n! ~ sqrt(2·Pi·n)·(n/e)^n
// for n = 1, ..., 10

MIN  = 1
MAX  = 10
STEP = 1

for n = MIN : STEP : MAX
	orig_val = factorial(n)
	appr_val = sqrt(2 * %pi * n) * (n / %e)^n

	abs_err = abs(orig_val - appr_val)
	rel_err = abs(abs_err / orig_val)
	per_err = rel_err * 100

	printf('input          %d\n'    , n)
	printf('value          %d\n'    , orig_val)
	printf('approximation  %f\n'    , appr_val)
	printf('absolute error %f\n'    , abs_err)
	printf('relative error %f\n'    , rel_err)
	printf('percent error  %.2f%%\n', per_err)
	printf('------------------------------------------\n')
end

// Results and Commentary
// ----------------------
// As 'n' increases the absolute error ('abs_err') increases.
// As 'n' increases the relative error ('rel_err') decreases.
//
// This means that as 'n' increases the magnitude between the exact
// value and the approximation increases, but, the affect of the
// difference lowers, as that magnitude becomes lesser important in
// comparison to the value.
// In other words, as 'n' increases, the magnitude between the exact
// and approximation value increases, but the pace with which that
// happens is much slower to the pace that the actual value increases,
// and slows down as the input increases, which in turn means that the
// magnitude becomes irrelevant for some big enough input.
//
// Output:
// > input          1
// > value          1
// > approximation  0.922137
// > absolute error 0.077863
// > relative error 0.077863
// > percent error  7.79%
// > ------------------------------------------
// > input          2
// > value          2
// > approximation  1.919004
// > absolute error 0.080996
// > relative error 0.040498
// > percent error  4.05%
// > ------------------------------------------
// > input          3
// > value          6
// > approximation  5.836210
// > absolute error 0.163790
// > relative error 0.027298
// > percent error  2.73%
// > ------------------------------------------
// > input          4
// > value          24
// > approximation  23.506175
// > absolute error 0.493825
// > relative error 0.020576
// > percent error  2.06%
// > ------------------------------------------
// > input          5
// > value          120
// > approximation  118.019168
// > absolute error 1.980832
// > relative error 0.016507
// > percent error  1.65%
// > ------------------------------------------
// > input          6
// > value          720
// > approximation  710.078185
// > absolute error 9.921815
// > relative error 0.013780
// > percent error  1.38%
// > ------------------------------------------
// > input          7
// > value          5040
// > approximation  4980.395832
// > absolute error 59.604168
// > relative error 0.011826
// > percent error  1.18%
// > ------------------------------------------
// > input          8
// > value          40320
// > approximation  39902.395453
// > absolute error 417.604547
// > relative error 0.010357
// > percent error  1.04%
// > ------------------------------------------
// > input          9
// > value          362880
// > approximation  359536.872842
// > absolute error 3343.127158
// > relative error 0.009213
// > percent error  0.92%
// > ------------------------------------------
// > input          10
// > value          3628800
// > approximation  3598695.618741
// > absolute error 30104.381259
// > relative error 0.008296
// > percent error  0.83%
// > ------------------------------------------

