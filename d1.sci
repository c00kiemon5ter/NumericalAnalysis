// Exercise D1
// ------------
// Implement the 1/3 simpson and 3/8 simpson methods
// ---------------------------------------------------------

function r=Simpson13(a,b,n)         // a,b upper and lower limits of the integral and n the compartments
    if modulo(n,2) != 0             // It must consist of 2K consecutive compartments. Meaning that n must be an even number
        n = n + 1;                  // if it's not then increase it by one
    end;
    h = (b-a)/n;                    // set the step
    head = h/3;
    firstAndLast = f(a) + f(b);     
    increase = h;
    x = a;
    summa = 0;

    for i=1:n-1
        x = x + increase;    
        if modulo(i,2) == 0 then 
            summa = summa + (2 * f(x)); 
        else 
            summa = summa + (4*f(x)); 
        end;
    end;
    r = [head * (summa + firstAndLast)] ;
endfunction

// ---------------------------------------------------------

function r=Simpson38(a,b,n)         // a,b upper and lower limits of the integral and n the compartments
    if modulo(n,3) != 0             // It must consist of 3K consecutive compartments. Meaning that n must be an even number
        n = n + (3 - modulo(n,3))   // if it's not then increase it by one
    end;
    h = (b-a)/(n);                  // set the step
    head = (3*h)/8;
    firstAndLast = f(a) + f(b);     
    increase = h;
    x = a;
    summa = 0;

    for i=1:n-1  
        x = x + increase;  
        if modulo(i,3) == 0 then 
            summa = summa + (2 * f(x)); 
        else
            summa = summa + (3 * f(x)); 
        end;
    end;
    r = [head * (summa + firstAndLast)] ;
endfunction

// ---------------------------------------------------------

function r=f(x)
    r = x * sin(x);
endfunction

// ---------------------------------------------------------

