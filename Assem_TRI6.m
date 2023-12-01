clear all
close all
elementos_nome_ficheiro = "ELEMENTOS.txt";

nos_nome_ficheiro = "NOS.txt";

[x, y, tri6] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro);

Nelt=size(tri6,1) ;       % numero de triangulos

Nnds =size(x,1)    ;       % numero de nos
%   inicializacao a zeros
Kg=zeros(Nnds,Nnds) ; 
fg=zeros(Nnds,1) ; 

%----------------------------------------------------------------------
%	Tarefa 54 : Assemblagem de elementos triangulares de 6-nós
%----------------------------------------------------------------------
for i=1:Nelt    
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
  edofs =[no1 no2 no3 no4 no5 no6]  ;  %   conectividade deste triangulo
  XN(1:6,1)=x(edofs) ; 
  XN(1:6,2)=y(edofs) ; 
  %     calculos no elemento
fL= 0.0 ; 
[Ke fe]=Elem_TRI6 (XN,fL) ; 

  %     assemblagem
  Kg(edofs,edofs)= Kg(edofs,edofs) + Ke  ;  % 
  fg(edofs,1)= fg(edofs,1) + fe     ;       % 
end %for i
Kg;
fg;
%----------------------------------------------------------------------
%	Tarefa 55 : Condicoes de fronteira essenciais 
%----------------------------------------------------------------------
fg = Neumann(x, y, fg);
%----------------------------------------------------------------------
%	Tarefa 56 : Resolver sistema de equações por backslash
%----------------------------------------------------------------------
u=Kg\fg ; 
uex=1-x.^2-y.^2 ; 
erru=abs(u-uex) ;	% calcular erro absoluto nos nos


figure(1)
Nelt=size(tri6,1) ; 
for i=1:Nelt
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
%----------------------------------------------------------------------
%	Tarefa 57 A : Representacao da malha e da solucao a 2D
%----------------------------------------------------------------------
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6)] ; 
fill (x(edofs),y(edofs),u(edofs));hold on
plot(x(edofs),y(edofs),'b');hold on
title('Representacao da malha e da solucao a 2D')
end
plot(x,y,'ro');

figure(12)
Nelt=size(tri6,1)
for i=1:Nelt
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
    

%----------------------------------------------------------------------
%	Tarefa 57 B : Representacao da malha e da solucao a 3D
%----------------------------------------------------------------------
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6)] ; 
fill3 (x(edofs),y(edofs),u(edofs),u(edofs));hold on
plot(x(edofs),y(edofs),'r');hold on
title('Representacao da malha e da solucao a 3D')
end
plot(x,y,'ro');

figure
Nelt=size(tri6,1) ; 
for i=1:Nelt
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
%----------------------------------------------------------------------
%	Tarefa 57 A : Representacao da malha e do erro a 2D
%----------------------------------------------------------------------
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6)] ; 
fill (x(edofs),y(edofs),erru(edofs));hold on
plot(x(edofs),y(edofs),'b');hold on
title('Representacao da malha e do erro a 2D')
end
plot(x,y,'ro');

figure
Nelt=size(tri6,1)
for i=1:Nelt
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
%----------------------------------------------------------------------
%	Tarefa 57 B : Representacao da malha e do erro a 3D
%----------------------------------------------------------------------
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6)] ; 
fill3 (x(edofs),y(edofs),erru(edofs),erru(edofs));hold on
plot(x(edofs),y(edofs),'r');hold on
title('Representacao da malha e do erro a 3D')
end
plot(x,y,'ro');

%
%----------------------------------------------------------------------
%	Tarefa 58 : Calcular (gradiente) fluxo nos centroides
%----------------------------------------------------------------------
Nelt=size(tri6,1) ; 
psi=zeros(6,1) ; 
figure
plot(x,y,'ro');hold on
title('fluxo nos centroides')
for i=1:Nelt
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
edofs =[no1 no2 no3 no4 no5 no6]  ;  %   conectividade deste triangulo
  XN(1:6,1)=x(edofs) ; 
  XN(1:6,2)=y(edofs)  ;  
csi=1/3 ; 
eta=1/3 ; 
%----------------------------------------------------------------
[B psi Detj]=Shape_N_Der6 (XN,csi,eta) ; 
%----------------------------------------------------------------

xpint = XN'*psi ; 
uint = psi'*u(edofs) ; 
uexi =1.-xpint(1)^2-xpint(2)^2 ; 
erri(i)= abs(uint-uexi)	 ; 	%	calcular erro absoluto no centroide
gradu = B'*u(edofs) ; 
fluxu = -gradu ; 
plot(xpint(1),xpint(2),'bx');hold on
quiver(xpint(1),xpint(2),fluxu(1),fluxu(2));hold on
end

maxeri =max(erri)	%	calcular maximo erro absoluto nos centroides
errumx=max(erru)    %	calcular maximo erro absoluto nos nos
erms= rms(erru)
