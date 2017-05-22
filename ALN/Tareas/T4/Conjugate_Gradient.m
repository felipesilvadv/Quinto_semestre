% Metodo de gradientes conjugados
n=2000;
%tol = 0;
function [x, flag, relres, iter, resvec] = CG(A, b, tol, maxit,x0)
  x = x0;
  n = length(b);
  normab = norm(b);
  u0 = b-A*x; 
  r0=u0;
  resvec = zeros(n,1);
  for i=(1:maxit)
    iter = i;
    err = norm(r0);
    relres = err/normab;
    resvec(i) = relres;
    if err < tol
      flag = 0;
      return
    endif
    inpd = A*u0;
    t = (r0'*r0)/(u0'*inpd);
    x = x + t*u0;
    r1 = r0 - t*inpd;
    b1 = (r1'*r1)/(r0'*r0);
    u0 = r1 + b1*u0;
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
%[x, flag, relres, iter, resvec] = CG(A, b, tol, maxit,x0);
%A(n,n) = 1000;
%cond(A,2)
%[x1, flag1, relres1, iter1, resvec1] = CG(A, b, tol, maxit,x0);
