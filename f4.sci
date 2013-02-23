// Exercise F4
// ------------
// Solve the   y= -5*x + 5*(t^2)+2*t equation with  0<=x<=2 and x0 = 1/3  with the improved Euler method
// ---------------------------------------------------------

function  [k,t,x]=eulercor(a, b, n, x0)     // k is the step, t the margin and x is the vector with the approaches
 
 h=(b-a)/n;                                 // set the step h
 t(1)=a;  
 t(1)=t(1)+h;                               // set the first t value for input to the g function 
 z(1)=x0+h* g(t(1),x0 ) ;                   // set with euler the first y that will be used for the improved euler
 x(1)=x0+ (g(t(1),x0)+g(t(1),z(1))  )*h/2 ;     
 
  for k=2:n                                 // do it again for each point of the compartment 
      t(k)=t(k-1)+h;
      z(k)=x(k-1)+h* g(t(k-1),x(k-1) ) ;
      x(k)=x(k-1)+ (g(t(k-1),x(k-1))+g(t(k),z(k))  )*h/2 ;  
  end
  
endfunction

// ---------------------------------------------------------

function  y=g(t, x)                         // The function i want to approach
    y= -5*x + 5*(t^2)+2*t;  
endfunction


