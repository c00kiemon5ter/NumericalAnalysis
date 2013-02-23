// Exercise B2
// ------------
// Approach the value of (( tan(x)*(( %e^ (2*x) )-1)) / (( %e^ (2*x) )+1))  +1 
// Use the methods of Bisection, Regula Falsi and Secant to
// approach the smallest positive solution with a precission
// of six decimal points.
// ---------------------------------------------------------

function R=bisection(a,b,nmax,tol)
  
 x(1)=(a+b)/2;                                    // Half original space
 if f(x(1))==0 then                               // if you find the root break 
   break
 else                                             // or else check in which space from [a,x(1)] h [x(1), b] the root is located
   if f(a)*f(x(1))<0 then                         // and then set afain the space a, b
      b=x(1);
   else
      a=x(1);
   end
 end

x(2)=(a+b)/2;
i=2;

while (abs(x(i-1)-x(i))>= tol) & (i<nmax)         // while the error space is larger than the difference
    if f(x(i))==0 then                            // and the number of repetitions is smaller than the max repeat
     break                                        // again the halfing of the original space until you find the root
    else
       if f(a)*f(x(i))<0 then
          b=x(i);
       else
          a=x(i);
       end
    end
    i=i+1;
    x(i)=(a+b)/2;
end
R=x
endfunction

// ---------------------------------------------------------

function R=regulafalsi(a,b,nmax,tol)
  i=1; 
  x(i)=(a*f(b)-b*f(a))/(f(b)-f(a));               // Find a first approach based on the formula and the initial a,b values 
  while (abs(b-a)>= tol) & (i<nmax)               // while the error is >= the wanted and the repetitions are less than max
         i=i+1; 
        x(i)= (a*f(b) - b*f(a)) / (f(b) - f(a));  // find the next x(i) 
        if (f(b)*f(x(i)) <= 0) then               // if you find the root in the space [b,x(i)] then change the space to that range
            a = x(i);       
        else    
            b = x(i);   
      end   
      R=x;
  end   
endfunction  

// ---------------------------------------------------------

function x=secant(x0, x1, nmax,tol )              // Start with to remote values x0 and x1
 
 x(1)=x0;
 x(2)=x1;
 i=2;
 x
 while i<=nmax & abs(x(i-1)-x(i))>=tol            // while the repetitions are < than nmax
                                                  // and the precision is > than the tolerance (tol) 
                                                  // do the same as in the newton-raphson method
     if (( f(x(i)) - f(x(i-1))) /(x(i)-x(i-1)) ) ~=0
      x(i+1)=x(i)-(f(x(i)*(x(i)-x(i-1)))/( f(x(i))-f(x(i-1)) ));
       i=i+1;
       else 
         break;
       end
 end 
 x
endfunction

// ---------------------------------------------------------

function y=f(x)
    y=(( tan(x)*(( %e^ (2*x) )-1)) / (( %e^ (2*x) )+1))  +1 ;
endfunction

// ---------------------------------------------------------
// Results:
// a) 1.570787 using the bisection method in the space of [1.5,1.6]  with  17 repetitions.
// b) 1.570788 using the regula falsi method in the space of [1.55,1.59]  with  37  repetitions.
// c) 1.570788 using the secant method in the space of [1.55,1.59]  with  37  repetitions.

