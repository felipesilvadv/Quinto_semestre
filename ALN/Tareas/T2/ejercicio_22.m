rand('state',0)
n=80;
eje = 1:1:n;
[U,X]=qr(randn(n)); [V,X]=qr(randn(n));
S=diag(2.^(-1:-1:-n));
A=U*S*V; %SVD de A
%v = linspace(2,2,n-1);
%A = eye(n) + diag(v, 1);
[Qc,Rc] = clgs(A); %Factorizacion QR via GS Clasico
[Qm,Rm] = mgs(A); %Factorizacion QR via GS Modificado
epsL=eps*ones(1,n);
epsSQ=sqrt(eps)*ones(1,n);
%plot(eje,diag(Rc),'+r',eje,diag(Rm),'ob',eje,diag(S),'-k');

semilogy(eje,diag(Rc),'+r',eje,diag(Rm),'ob',eje,diag(S),'-k')
hold on
semilogy(eje,epsL,'-g', eje,epsSQ,'-g')