n = 100
A = rand(n,n);
B = rand(n,n);
C = zeros(n,n);
D = zeros(n,n);
E = A*B;
for i = (1:n)
  for j = (1:n)
    C(i,j) = A(i,:)*B(:,j);
  endfor
endfor

for i = (1:n)
  for j = (1:n)
    D(:,i) += A(:,j)*B(j,i);
  endfor
endfor

norm(C-D)
norm(E-C)
norm(E-D)
%% Resultados obtenidos para distintos n
%% los dejo escritos porque el codigo es lento
%>> ejercicio16
%n =  100
%ans =    1.3067e-13
%ans =    1.3067e-13
%ans = 0
%>> ejercicio16
%n =  200
%ans =    5.2205e-13
%ans =    5.2205e-13
%ans = 0
%>> ejercicio16
%n =  500
%ans =    3.1133e-12
%ans =    1.7867e-12
%ans =    3.3070e-12
%>> ejercicio16
%n =  1000
%ans =    1.2262e-11
%ans =    4.1434e-12
%ans =    1.2777e-11
%>> ejercicio16
%n =  2000
%ans =    4.9310e-11
%ans =    8.4058e-12
%ans =    4.9990e-11