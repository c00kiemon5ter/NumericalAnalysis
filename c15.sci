// Exercise C15
// ------------
// For the function f(x)= sin(x) find the following splines
// 1) linear set by the points (4, f(4) and (6, f(6))
// 2) linear set by the points (4.5, f(4.5) and (5.5, f(5.5))
// 3) cubic set by the points (4, f (4), (4.5, f(4.5),(5.5, f(5.5)) and (6, f(6))
// 4) the hermite polynomial in the points (4, f(4)), (4, f′(4)), (6, f(6)) and (6, f′(6))
// 5) the hermite polynomial in the points (4.5, f(4.5)), (4.5, f′(4.5)), (5.5, f(5.5)) and (5.5, f ′(5.5))
// for each of those calculate the error for x=5 for the space [4.6]
// ---------------------------------------------------------

function y = linearA(x)
    y = f(4) + (f(6) - f(4)/(6-4))*(x - 4);
endfunction

// ---------------------------------------------------------

function y = linearB(x)
    y = f(4.5) + (f(5.5) - f(4.5)/(5.5-4.5))*(x - 4.5);
endfunction

// ---------------------------------------------------------

function y = f(x)
    y = sin(x);
endfunction

// ---------------------------------------------------------

function y = def(x) //the derivative of f
    y = cos(x);
endfunction

// ---------------------------------------------------------

function  ci=cubicinterpolation(x)
      
        ci= -0.7568025 - 0.4414552*(x-4)+0,47563*((x^2)-8.5*x+18)-0.0443951*((x^3)-14*(x^2)+18*x-52.25);
      
endfunction

// ---------------------------------------------------------

function  hp=hermite1(x)
//p= f(4.5)*(1+2*(x-4.5))*(x^2-9*x+(4.5)^2) + def(4.5)*(x-4.5)*(x^2-9*x+(4.5)^2) + f(5.5)*(1-2*(x-5.5))*(x^2-11*x+(5.5)^2) + def(5.5)*(x-5.5)*(x^2-11*x+(5.5)^2) ;

for i=1:length(x)                     // for all the spots of the polynomial calculate the result of the hermite polynomial
  h01=(1-(x(i)-4))*((x(i)^2 - 8*x(i)+16)/4); //calculate the Hi1 and Hi2
  h02=(x(i)-4)*((x(i)^2-8*x(i)+16)/4);
  h12=(1-(x(i)-6))*((x(i)^2-12*x(i)+36)/4);
  h22=(x(i)-6)*((x(i)^2-12*x(i)+36)/4);
  
  hp(i)=f(4)*h01 + def(4)*h02+ f(6)*h12 + def(6)*h22;
 end

endfunction 

// ---------------------------------------------------------

function p=hermite2(x)

for i=1:length(x)
  h01=(1-2*(x(i)-4.5))*(x(i)^2-9*x(i)+(4.5)^2); 
  h02=(x(i)-4.5)*(x(i)^2-9*x(i)+(4.5)^2);
  h12=(1-2*(x(i)-5.5))*(x(i)^2-11*x(i)+(5.5)^2);
  h22=(x(i)-5.5)*(x(i)^2-11*x(i)+(5.5)^2);
  
  p(i)= f(4.5)*h01 + def(4.5)*h02 + f(5.5)*h12 + def(5.5)*h22 ;
end

endfunction

// ---------------------------------------------------------
// Results: 
// For each function the error is Q(x)= Sin(x)- P(x) where P(x) is 
// the polynomial that approaches it's true value. So the max error is 
// calculated from the derivative of Q(x). 
// The max errors are: 
// 1) 0.2794155
// 2) 0.3567225
// 3) 1.3602974  
// 4) 2.0017846
// 5) 8.4472365
