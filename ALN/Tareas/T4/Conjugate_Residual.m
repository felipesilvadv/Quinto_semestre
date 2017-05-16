% Metodo de Residuales conjugados
n = 2000;
%B = sprand(n,n, 0.2);
%[Q, R] =qr(B);
%Q = sparse(Q);
%A = sparse(Q'*diag(B(1,:))*Q);
%cond(A,2)
%b = ones(n,1);
%x0 = ones(n,1);
%tol = 1e-15;
%tol = 0
function [x, flag, relres, iter, resvec] = CR(A, b, tol, maxit,x0)
  x = x0;
  p0 = b-A*x; 
  r0=p0;
  pdmp = A*p0;
  n = length(b);
  normab = norm(b);
  resvec = zeros(n,1);
  for i = 1:maxit
    err = norm(r0);
    iter = i;
    relres = err/normab;
    resvec(i) = relres;
    if err<tol
      flag = 0;
      return  
    endif
    pdmr = A*r0;
    a = (r0'*pdmr)/(pdmp'*pdmp);
    x = x + a*p0;
    r1 = r0-a*pdmp;
    pdmr1 = A*r1;
    b1 = (r1'*pdmr1)/(r0'*pdmr);
    p0 = r1 + b1*p0;
    pdmp = pdmr1 + b1*pdmp;
    estanco = norm(r0-r1);    
    if estanco < tol
      flag = 2;
      return
    endif
    r0 = r1;
  endfor
  if err > 1e-3
    flag = 1;
    return
  elseif err < 1e-10
    flag = 0;
    return
  endif
endfunction
