// Exercise E3
// ------------
// Implement the cholesky analysis for a band and symmetric array 
// so that you avoid unnecessary calculations. 
// ---------------------------------------------------------

function L=cholesky(A)
[m,n]=size(A);

if m~=n then
  disp('matrix u is not square');
  return;
end

for k=1:n
    for i=1:k-1 
        s=0;
        if (i~=1) then
            s=A(i, 1:i-1)*A(k, 1:i-1)';
        end
        A(k,i)=(A(k,i)-s)/A(i,i);
     end
     s=0;
     if(k~=1) then
          s=A(k, 1:k-1)*A(k, 1:k-1)';
     end
     A(k,k)= (A(k,k)-s)^0.5;
end
L=tril(A);

endfunction 

// ---------------------------------------------------------

function L=choleskyBand(A)
[m,n]=size(A);

if m~=n then
  disp('matrix u is not square');
  return;
end

for k=1:n
    for i=1:k-1 
        s=0;
        if (i~=1) then
            s=A(i, i-1)*A(k, i-1);
        end
        A(k,i)=(A(k,i)-s)/A(i,i);
     end
     s=0;
     if(k~=1) then
          s=A(k, k-1)*A(k, k-1);
     end
     A(k,k)= (A(k,k)-s)^0.5;
end
L=tril(A);


endfunction 

// ---------------------------------------------------------
// Creates a sample table for testing

function A=Table(n)  // n is the size of the array
  A=zeros(n,n);      // initially fill it with zeros
  A(1,1)=2; 
  A(1,2)=-1;
  for i=2:n-1
    A(i,i-1)=-1; A(i,i)=2; A(i,i+1)=-1;
  end
  A(n,n-1)=-1; A(n,n)=2;
endfunction

// ---------------------------------------------------------

