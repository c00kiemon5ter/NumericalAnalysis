// Exercise A12
// ------------
// Calculate the result of the sum 
// Sum 0->n(((-1)^j)*(x^(2*j+1)))/factorial(2*j+1)
// for x = 0.1, 1 and 10 and n = 10, 100, 1000, 10000
// Also calculate the absolute relative error

function y=sum(x,n) 
  
    y=0;                              //the sum starts from 0
    for j=0:n                         //from 0 to n
        y=y+ (((-1)^j)*(x^(2*j+1)))/factorial(2*j+1);
    end  
            
endfunction

function y=sumrev(x,n) 
                    
    y=0;                              //the sum starts from 0
    for j=n:-1:0                      //from n to 0 with a -1 step
        y=y+ (((-1)^j)*(x^(2*j+1)))/factorial(2*j+1);
    end  
                                 
endfunction
                                    
