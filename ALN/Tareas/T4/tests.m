Conjugate_Gradient
Conjugate_Residual
clear
n = 2000;
B = rand(n,n);
[Q, R] =qr(B);
d = B(1,:);
A = Q'*diag(d)*Q;
b = ones(n,1);
x0 = ones(n,1);
tol = 1e-15;
maxit = n;
% Caso Estandar-Random
[xR, flagR, relresR, iterR, resvecR] = CR(A, b, tol, maxit,x0);
[x, flag, relres, iter, resvec] = CG(A, b, tol, maxit,x0);
condicionamiento = cond(A,2)
result = A\b;
% Caso Mal condicionamiento
A(1,1) = 0.001;
A(n,n) = 10000000;
condicionamiento1 = cond(A,2)
[xR1, flagR1, relresR1, iterR1, resvecR1] = CR(A, b, tol, maxit,x0);
[x1, flag1, relres1, iter1, resvec1] = CG(A, b, tol, maxit,x0);
result1 = A\b;
% Caso mal condicionado y autovalores cluster
d = zeros(n,n);
valor = abs(n/5);
for i = 1:n
  if i < valor
    d(i,i) = 10; 
  elseif i < valor*2
    d(i,i) = 100;
  elseif i < valor*3
    d(i,i) = 1000;
  elseif i < valor*4
    d(i,i) = 10000;
  else
    d(i,i) = 10000000;  
  endif
endfor  
A = Q'*d*Q;
condicionamiento2 = cond(A,2)
[xR2, flagR2, relresR2, iterR2, resvecR2] = CR(A, b, tol, maxit,x0);
[x2, flag2, relres2, iter2, resvec2] = CG(A, b, tol, maxit,x0);
% Caso bien condicionado y autovalores cluster
d = zeros(n,n);
valor = abs(n/5);
for i = 1:n
  if i < valor
    d(i,i) = 10; 
  elseif i < valor*2
    d(i,i) = 11;
  elseif i < valor*3
    d(i,i) = 12;
  elseif i < valor*4
    d(i,i) = 13;
  else
    d(i,i) = 14;  
  endif
endfor  
A = Q'*d*Q;
condicionamiento3 = cond(A,2)
[xR3, flagR3, relresR3, iterR3, resvecR3] = CR(A, b, tol, maxit,x0);
[x3, flag3, relres3, iter3, resvec3] = CG(A, b, tol, maxit,x0);