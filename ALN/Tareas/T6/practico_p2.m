% Matriz de Wilkinson
clear
n = 12;
A = diag(n:-1:1) + diag(2:1:n, -1);
[V,D] = eig(A);
[W, D1] = eig(A');
s = zeros(n,1);
c = zeros(n,1);
for i = 1:n;
  s(i) = W(:,i)'*V(:,i);
  c(i) = 1/s(i);
endfor
cv = cond(V)*ones(n,1) ;
lambda = eig(A);
%datos = []
%file = fopen("A_normal.txt","w");
%fdisp(file,datos);
%fclose(file)
% matriz perturbada
A(n,1) = 1e-5;
v1 = eig(A);
df1 = abs(v1-lambda);
datos = [lambda v1 df1 cv c]
file = fopen("A_np5.txt","w");
fdisp(file,datos);
fclose(file)
A(n,1) = 1e-7;
v2 = eig(A);
df2 = abs(v2-lambda);
datos = [lambda v2 df2 cv c]
file = fopen("A_np7.txt","w");
fdisp(file,datos);
fclose(file)
A(n,1) = 1e-10;
v3 = eig(A);
df3 = abs(v3-lambda);
datos = [lambda v3 df3 cv c]
file = fopen("A_np10.txt","w");
fdisp(file,datos);
fclose(file)


% Matriz de Wilkinson Traspuesta

clear
n = 12;
A = diag(n:-1:1) + diag(2:1:n, -1);
A = A';
[V,D] = eig(A);
[W, D1] = eig(A');
s = zeros(n,1);
c = zeros(n,1);
for i = 1:n;
  s(i) = W(:,i)'*V(:,i);
  c(i) = 1/s(i);
endfor
cv = cond(V)*ones(n,1);
lambda = eig(A);
%datos = []
%file = fopen("A_t.txt","w");
%fdisp(file,datos);
%fclose(file)
% matriz perturbada
A(n,1) = 1e-5;
v1 = eig(A);
df1 = abs(v1-lambda);
datos = [lambda v1 df1 cv c]
file = fopen("A_tp5.txt","w");
fdisp(file,datos);
fclose(file)
A(n,1) = 1e-7;
v2 = eig(A);
df2 = abs(v2-lambda);
datos = [lambda v2 df2 cv c]
file = fopen("A_tp7.txt","w");
fdisp(file,datos);
fclose(file)
A(n,1) = 1e-10;
v3 = eig(A);
df3 = abs(v3-lambda);
datos = [lambda v3 df3 cv c]
file = fopen("A_tp10.txt","w");
fdisp(file,datos);
fclose(file)