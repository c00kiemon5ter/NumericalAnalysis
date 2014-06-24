%
% LU decomposition implementation step by step 
% ( and as example we use it to calculate the reverse of a matrix)
% we implement also a version of LU for band matrixes 
% We generate some example band matrixes for various n sizes with
% our band_matrixes function. Finally we plot the times of simple LU 
% and LU band to compare the two methods. Generally the plot shows that
% LU complexity O(n^3) and LU for band matrixes is O(n)
%
function []  = e7()

fprintf('a) part of the exercise\n');;
fprintf('## LUb goes for the LU band implemention\n\n');
%the n values we will use for calculating the time spent
ni = [ 64, 128, 256, 512 ];

%initialize the array where we will save the time measures
[times, times_band] = deal(zeros(length(ni),1));

i = 1;
for n = ni
    %let's construct the (3) band matrix of the exercise for various n spaces
    A = band_matrix(2, -1, n, 0);
    
    %start the timecount
    tic;
    LU(A);
    time_LU = toc;
    
    %now we will test the same band matrix but with the LU_band
    tic;
    LU_band(A);
    time_LU_band = toc;
    
    times(i) = time_LU;
    times_band(i) = time_LU_band;
    
    fprintf('LU  with n: %d, time: %.15f \n', n, time_LU);
    fprintf('LUb with n: %d, time: %.15f \n\n', n, time_LU_band); 
    
    i = i + 1;
end

hold on;
p1 = plot(ni, times);
p2 = plot(ni, times_band);
set(p2, 'Color', 'red');
leg = legend([p1, p2], 'LU', 'LU band');
set(leg,'Location','NorthWest');
xlabel('n size of matrix')
ylabel('time spent')
hold off;


%%%%%%%% b) second part of exercise
fprintf('Second part of the exercize\n\n');

% we generate the (3) A matrix of the projects' description
nc = 64;
A = band_matrix(2, -1, nc, 0);
b = ones(nc, 1);

[~, L, U] = LU_band(A);

% We want to solve A*x = b
%
% A*X = I, having now P and  L U matrixes:
% P*A*x = P*b  ==>  L*U*x = b
%
% set the U*x = y then we will have L*y = b.
%
% then first we solve the L*y = P*b (y = L\b)
% 
% and then solve the U*x = y (x = U\y) to get x vector
%
%
%y = L\b;
y = forward_subs(L,b);
%
%x = U\y;
x = backward_subs(U,y);

fprintf('Vector x:\n')

%%%% c) part of the exercise
fprintf('c) part of the exercise\n\n');
fprintf('Reverse matrix:\n');

% here we will use the same matrix as before:
% actually the products of LU decomposition from previous part
%get_reverse(A);
end

%implementation of LU with partial pivoting
function [P, L, U] = LU(A)
% Make sure A is nxn
sz = size(A);
if sz(1)~=sz(2)
    fprintf('A is not n by n\n');
    return;
end

n = sz(1);
%initialize the matrixes we will need
[P, L] = deal(eye(n));
U = A;



for i = 1:n
    %first perform partial pivoting:
    %get the maximum of the column
    max_value = max(abs(U(i:end,i)));
    
    if max_value ~= A(i,i)
        for k = i:n
            if max_value == U(k,i) && i ~= n
                %swap the row starting with 0
                %with the row containing the maximum
                %value in the current column
                temp = U(i,:);
                U(i,:) = U(k,:);
                U(k,:) = temp;

                temp = P(i,:);
                P(i,:) = P(k,:);
                P(k,:) = temp;

                %when a row changes we also change 
                %the corresponding multipliers of L
                if i ~= 1
                    L_temp = L(i,1:i-1);
                    L(i,1:i-1) = L(k,1:i-1);
                    L(k,1:i-1) = L_temp;
                end
                
                %once we make the desired change break out of the loop
                break;

            end
        end
    end
    
    %case all the points below pivot are zero
    if U(i,i) == 0
        continue;
    end
    %if it is not the last row of the matrix
    if i ~= n
        current_row = U(i,:);
        
        %for each row make the points below pivot zero
        for j = i+1:n
            % - a21/a11
            multiplier = - (U(j,i)/ U(i,i));    
            U(j,:) = U(j,:) + multiplier*current_row;
            
            %store the positive multiplier to L matrix
            L(j,i) = - multiplier;
        end
    end
    
end

end

%implementation of LU with partial pivoting for band matrixes
function [P, L, U] = LU_band(A)

% Make sure A is nxn
sz = size(A);
if sz(1)~=sz(2)
    fprintf('A is not n by n\n');
    return;
end

n = sz(1);
[P, L] = deal(eye(n));
U = A;

%should be symmetric
diag_num = sum(A(:,1)~=0);

for i = 1:n
    %in band matrixes all the elements below and over
    %the diagonals are zero, so each time we only loop
    %for the number of diagonal (avoid unnecessary loops and calculations)
    max_loop = i+diag_num-1;
    if n < max_loop
        max_loop = n;
    end
    
    %partial pivoting
    max_value = max(abs(U(i:max_loop,i)));
    
    %perform only on the diagonals and not to the other lines
    %which contain zero values (control that each time by max_loop)
    if max_value ~= A(i,i)
        for k = i:max_loop
            if max_value == U(k,i) && i ~= n
                %swap the row starting with 0
                %with the row containing the maximum
                %value in the current column
                temp = U(i,:);
                U(i,:) = U(k,:);
                U(k,:) = temp;

                temp = P(i,:);
                P(i,:) = P(k,:);
                P(k,:) = temp;

                %when a row changes we also change 
                %the corresponding multipliers of L
                if i ~= 1
                    L_temp = L(i,1:i-1);
                    L(i,1:i-1) = L(k,1:i-1);
                    L(k,1:i-1) = L_temp;
                end

                break;
            end
        end
    end
    
    %case all the points below pivot are zero
    if U(i,i) == 0
        continue;
    end
    
    %if it is not the last row of the matrix
    if i ~= n
        current_row = U(i,:);
        
        %again make only the necessary loops
        max_loop = i+diag_num-1;
        if n < max_loop
            max_loop = n;
        end
        
        %for each row make the points below pivot zero
        %with max_loop avoid unnecessary loops
        for j = i+1:max_loop
            % - a21/a11
            multiplier = - (U(j,i)/ U(i,i));   
            U(j,:) = U(j,:) + multiplier*current_row;
            
            %store the positive multiplier to L matrix
            L(j,i) = - multiplier;
        end
    end
    
end

end

%having the results of LU decomposition we can calculate the reverse matrix
function [ X ] = get_reverse(A)
% A^-1 the reverse of the matrix A
%
% for the reverse we have that A*A^-1 = I
% let's name the A^-1 X, then
% A*X = I, having now P and  L U matrixes:
% P*A*X = P*I  ==>  L*U*X = P*I
%
% set the U*X = y then we will have L*y = P*I.
%
% then first we solve the L*y = P*I (y = L\P*I)
% 
% and then solve the U*X = y (X = U\y) to get th reverse matrix
%
[P, L, U] = LU(A);

I = eye(size(L));
%y = L \ ( P*I );
PI = P*I;
y = zeros(size(PI));

%because in this case P*I is a matrix and not a single vector
%we run forward_subs for each column
for i = 1:length(PI)
    y(:,i) = forward_subs(L, PI(:,i));
end
%
%X = U \ y;
X = zeros(size(y));

for i = 1:length(y)
    X(:,i) = backward_subs(U, y(:,i));
end

end

%solve A*x = b by calculating x = A\b where
%A is a triangular matrix so we use forward substitutes
function [ x ] = forward_subs(A,b)
%A is nxn
A_length = length(A);
x = zeros(A_length, 1);

for i = 1:A_length
    sum = 0;
    for j = 1:i-1
        sum = sum + A(i,j)*x(j);
    end
    x(i) = (b(i) - sum) / A(i,i);
end

end

%solve A*x = b by calculating x = A\b where
%A is an upper triangular matrix so we use backward substitutes
function [ x ] = backward_subs(A,b)
%A is nxn
A_length = length(A);
x = zeros(A_length, 1);

for i = A_length:-1:1
    sum = 0;
    for j = A_length:-1:i+1
        sum = sum + A(i,j)*x(j);
    end
    x(i) = (b(i) - sum) / A(i,i);
end

end


% generates 3-diagonal symmetric nxn band matrix
% a = values of the main diagonal
% b = values of the -1 and 1 diagonal 
%   (left and right of the main) symmetric
% n size of matrix
% m(mode) = if 1 then values out of diagonals should be ones
%   else zeros 
%this function is used to generate the exercise's example matrixes
function A = band_matrix(a, b ,n, m)
    main_diagonal = a * ones(n, 1); 
    off_diagonal =  b * ones(n - 1, 1);
    
    A = diag(main_diagonal) + diag(off_diagonal, 1) + diag(off_diagonal, -1);

    if m == 1
        %matrix with ones except from the 3 diagonals which contain zeros
        B = ones(n) - diag(ones(n, 1)) -diag(ones(n-1, 1), 1)  - diag(ones(n-1, 1), -1);
        A = A + B;
    end

end
