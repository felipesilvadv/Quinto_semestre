e = 1;
while 1+e != 1,
  e = e/2;
  endwhile 
e
valor = 1 + 2 * e;
while 1+ 2*e == valor,
  e = e*2;
  endwhile
e
while 1 + 2*e + e^2 != 1 + 2*e,
  e = e/2
  endwhile
e
% con esto econtramos el valor de e

v1 = [1+e 1 1].';
v2 = [1 1+e 1].';
v3 = [1 1 1+e].';
A = [v1 v2 v3]
clgs(A)
mgs(A);
u1 = (1/(sqrt(3+2*e)))*v1
u2 = (1/sqrt(2))*[-1 1 0].'
u3 = (1/sqrt(2))*[-1 0 1].'
B = ones(3);