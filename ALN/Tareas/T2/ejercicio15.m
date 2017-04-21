A = [9.3040*10^(-1) 9.1960*10^(-2) 7.0120*10^(-1)
     8.4620*10^(-8) 6.5390*10^(-8) 9.1030*10^(-8)
     5.2690*10^(-15) 4.1600*10^(-15) 7.6220*10^(-15)];
[Q,R] = qr(A);
x1 = ones(3,1);
b = A*x1;
v = Q.'*b;
x2 = R \v
error1 = norm(x2-x1) % Si es una buena aproximación
A = [A(3,:);A(2,:);A(1,:)];
[Q,R] = qr(A);
x1 = ones(3,1);
b = A*x1;
v = Q.'*b;
x2 = R \v
error2 = norm(x2-x1)% No es una buena aproximación