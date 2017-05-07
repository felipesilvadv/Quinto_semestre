n = 9;
A=eye(n);
b = ones(n,1);
A(:,1)=b;
c = A'*A;
syms h
d = diag(ones(n,1),n,n);
e = c-d
%eig(c);
