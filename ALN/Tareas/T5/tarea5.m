[A2,rows2,cols2,entries2,rep2,field2,symm2] = mmread("spd.mtx");
% Caso de Matrix SPD
% se resuelve mediante CG y CR
n = length(A2);
x = ones(n,1);
b = A2*x;
n = 100; 
% Graficos 
%x = 0:0.01:3;
%hf = figure ();
%plot(spy(A2));
%hold on;
%title ("Diagrama de esparcidad de la matriz");
%set (hf, "visible", "off");
%print (hf, "./datos/plotspd.pdf", "-dpdflatexstandalone");
%set (hf , "visible", "on");
%cd datos/
%system ("pdflatex plotspd-inc.pdf");
%cd ../

[L,U] = ilu(A2);
opts.type = "nofill";
[l,u] = ilu(A2,opts);
opts.type = "ilutp"
[L2,U2] = ilu(A2,opts);
%%%% CG
% Precondicionado con ilu standar
[x, flag, relres, iter, relvec, eigs]=pcg(A2, b, 1e-8, n, L,U);
% Precondicionado con ilu nofill
[x1, flag1, relres1, iter1, relvec1, eigs1]=pcg(A2, b, 1e-8, n, l,u);
% Precondicionado con ilu ilutp
[x2, flag2, relres2, iter2, relvec2, eigs2]=pcg(A2, b, 1e-8, n, L2,U2);
% Sin precondicionar
[x_np, flag_np, relres_np, iter_np, relvec_np, eigs_np]=pcg(A2, b, 1e-8, n);

%%%% CR
% Precondicionado con ilu standar
[xR, flagR, relresR, iterR, relvecR, eigsR]=pcr(A2, b, 1e-8, n, L,U);
% Precondicionado con ilu nofill
[xR1, flagR1, relresR1, iterR1, relvecR1, eigsR1]=pcr(A2, b, 1e-8, n, l,u);
% Precondicionado con ilu ilutp
[xR2, flagR2, relresR2, iterR2, relvecR2, eigsR2]=pcr(A2, b, 1e-8, n, L2,U2);
% Sin precondicionar
[xR_np, flagR_np, relresR_np, iterR_np, relvecR_np, eigsR_np]=pcr(A2, b, 1e-8, n);
datos = [flag relres iter;
         flag1 relres1 iter1;
         flag2 relres2 iter2;
         flag_np relres_np iter_np]';
datosR = [flagR relresR iterR;
         flagR1 relresR1 iterR1;
         flagR2 relresR2 iterR2;
         flagR_np relresR_np iterR_np]';
file = fopen("./datos/CG.txt","w");
fdisp(file,datos);
fclose(file)
file = fopen("./datos/CR.txt","w");
fdisp(file, datosR);
fclose(file)

% Caso de Matrix Simetrica indefinida
% se resuelve mediante SYMMLQ y Dlanczos
%Queda pendiente 
clear
[A3,rows3,cols3,entries3,rep3,field3,symm3] = mmread("sindef.mtx");
n = length(A3);
x = ones(n,1);
b = A3*x;
n = 100;
[L,U] = ilu(A3);
opts.type = "nofill";
[l,u] = ilu(A3, opts);
opts.type = "ilutp";
[L2, U2] = ilu(A3,opts);

%%%%GMRES
% Precondicionado con ilu standar
[x, flag, relres, iter, relvec]=gmres(A3, b, 1000, 1e-8, L, U);
% Precondicionado con ilu nofill
[x1, flag1, relres1, iter1, relvec1]=gmres(A3, b,1000, 1e-8, l, u);
% Precondicionado con ilu ilutp
[x2, flag2, relres2, iter2, relvec2]=gmres(A3, b, 1000, 1e-8, n, L2, U2);
% Sin precondicionar
[x_np, flag_np, relres_np, iter_np, relvec_np]=gmres(A3, b, 1000, 1e-8, n);

%%%% BCGSTAB 
% Precondicionado con ilu standar
[xB, flagB, relresB, iterB, relvecB]=bicgstab(A3, b, 1e-8, L, U);
% Precondicionado con ilu nofill
[xB1, flagB1, relresB1, iterB1, relvecB1]=gmres(A3, b, 1e-8, l, u);
% Precondicionado con ilu ilutp
[xB2, flagB2, relresB2, iterB2, relvecB2]=gmres(A3, b, 1e-8, n, L2, U2);
% Sin precondicionar
[xB_np, flagB_np, relresB_np, iterB_np, relvecB_np]=gmres(A3, b, 1e-8, n);
datos = [flag relres iter;
         flag1 relres1 iter1;
         flag2 relres2 iter2;
         flag_np relres_np iter_np]';
file = fopen("./datos/SGMRES.txt","w");
fdisp(file,datos);
fclose(file)
datosB = [flagB relresB iterB;
         flagB1 relresB1 iterB1;
         flagB2 relresB2 iterB2;
         flagB_np relresB_np iterB_np]';
file = fopen("./datos/SBCGSTAB.txt","w");
fdisp(file,datos);
fclose(file)

% Caso matrix general 
% GMRES y BCGSTAB
clear
[A1,rows1,cols1,entries1,rep1,field1,symm1] = mmread("normal.mtx");
n = length(A1);
x = ones(n,1);
b = A1*x;
n = 100;
[L,U] = ilu(A1);
opts.type = "nofill";
[l,u] = ilu(A1, opts);
opts.type = "ilutp";
[L2, U2] = ilu(A1,opts);

%%%%GMRES
% Precondicionado con ilu standar
[x, flag, relres, iter, relvec]=gmres(A1, b, 1000, 1e-8, L, U);
% Precondicionado con ilu nofill
[x1, flag1, relres1, iter1, relvec1]=gmres(A1, b,1000, 1e-8, l, u);
% Precondicionado con ilu ilutp
[x2, flag2, relres2, iter2, relvec2]=gmres(A1, b, 1000, 1e-8, n, L2, U2);
% Sin precondicionar
[x_np, flag_np, relres_np, iter_np, relvec_np]=gmres(A1, b, 1000, 1e-8, n);

%%%% BCGSTAB 
% Precondicionado con ilu standar
[xB, flagB, relresB, iterB, relvecB]=bicgstab(A1, b, 1e-8, L, U);
% Precondicionado con ilu nofill
[xB1, flagB1, relresB1, iterB1, relvecB1]=gmres(A1, b, 1e-8, l, u);
% Precondicionado con ilu ilutp
[xB2, flagB2, relresB2, iterB2, relvecB2]=gmres(A1, b, 1e-8, n, L2, U2);
% Sin precondicionar
[xB_np, flagB_np, relresB_np, iterB_np, relvecB_np]=gmres(A1, b, 1e-8, n);
datos = [flag relres iter;
         flag1 relres1 iter1;
         flag2 relres2 iter2;
         flag_np relres_np iter_np]';
file = fopen("./datos/GMRES.txt","w");
fdisp(file,datos);
fclose(file)
datosB = [flagB relresB iterB;
         flagB1 relresB1 iterB1;
         flagB2 relresB2 iterB2;
         flagB_np relresB_np iterB_np]';
file = fopen("./datos/BCGSTAB.txt","w");
fdisp(file,datos);
fclose(file)
