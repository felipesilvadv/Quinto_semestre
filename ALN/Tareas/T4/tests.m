Conjugate_Gradient
Conjugate_Residual
[xR, flagR, relresR, iterR, resvecR] = CR(A, b, tol, maxit,x0);
[x, flag, relres, iter, resvec] = CG(A, b, tol, maxit,x0);
condicionamiento = cond(A,2)
A(n,n) = 10000000;
condicionamiento = cond(A,2)
[xR1, flagR1, relresR1, iterR1, resvecR1] = CR(A, b, tol, maxit,x0);
[x1, flag1, relres1, iter1, resvec1] = CG(A, b, tol, maxit,x0);