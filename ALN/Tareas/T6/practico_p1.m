% Ejemplos de parte 1
clear
n = 5;
%mu = 3;
A = rand(n,n);
[Q,R]= qr(A);
A = Q * (diag(1:1:n)*5)*Q';
lambda = eig(A);
algo = lambda(5);
lambda = algo + 0.1;
B = A - lambda * eye(n);  
C = A - (lambda + 100) *eye(n);
c = cond(C)
b = cond(B)
q = rand(n,1);
q = q/norm(q);
q1 = q/norm(q);
maxiter = 100000;
%B1 = inverse(B);
%C1 = inverse(C);
z = q;
for i = 1:maxiter;
  %if det(B) < 1e-6;
   % flag = 1;
   % break
  %endif
  z = gmres(B,q);
  q = z/norm(z,2);
  mu = z'*A*z/(z'*z);
  B = A - mu*eye(n);
  residual = norm(A*z - mu*z);
  if residual < 1e-6;
    flag =0;
    break
  endif
endfor

for j = 1:maxiter;
  %if norm(det(C)) < 1e-6;
   % flag1 = 1;
   % break
  %endif
  %C1 = inverse(C);
  z1 = gmres(C,q1);
  q1 = z1/norm(z1,2);
  mu1 = z1'*A*z1/(z1'*z1);
  C = A - mu1*eye(n);
  residual1 = norm(A*z1 - mu1*z1);
  if residual1 < 1e-6;
    flag1 = 0;
    break
  endif
endfor
eig(A)


