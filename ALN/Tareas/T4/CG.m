% Metodo de gradientes conjugados
n = 10000
B = rand(n,n);
[Q, R] =qr(B);
A = Q'*diag(B(1,:))*Q;
b = ones(n,1);
x0 = ones(n,1);
u0 = b-A*x0; 
r0=u0;
tol = 1e-15;
%tol = 0;
for i=(1:n)
  if norm(r0) < tol
    norm(r0)
    i
    return
  endif
  inpd = A*u0;
  t = (r0'*r0)/(u0'*inpd);
  x0 = x0 + t*u0;
  r1 = r0 - t*inpd;
  b1 = (r1'*r1)/(r0'*r0);
  u0 = r1 + b1*u0;
  r0 = r1;
endfor
resultado= A\b;
error = norm(r0)
error2 = norm(resultado-x0)
