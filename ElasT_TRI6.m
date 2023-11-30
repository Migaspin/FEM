clear all %#ok<*CLALL>
close all
%-----------------------------------------------------
%       Tarefa 3 : Gerar a topologia ou conectividade
%-----------------------------------------------------
x=[0 2.5 5 7.5 10 0 2.5 5 7.5 10 0 2.5 5 7.5 10]'
y=[0 0 0 0 0 1 1 1 1 1 2 2 2 2 2]'
%
%   definicao "manual" da malha: teste com 4 TRI-6
tri6=[1 3 13 2 8 7;1 13 11 7 12 6;3 5 15 4 10 9;3 15 13 9 14 8]
  
%   fim da geracao de malha aqui
%--------------------------------------------------------------------------
%   Tarefa 39, 1a parte : seccao para desenhar a malha de quads-4
%--------------------------------------------------------------------------
%

figure
Nelt=size(tri6,1) ; 
for i=1:Nelt
%	Tarefa 57 A : Representacao da malha e da solucao a 2D
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6)] ; 
plot(x(edofs),y(edofs),'b');hold on
end
plot(x,y,'ro');

%   fim da visualizacao da malha

he=1.0
niu=0.25
E=30.e+6
%       tensao plana
cons=E/(1-niu*niu)
C=cons*[1 niu 0;niu 1 0;0 0 (1-niu)/2]

Nnds =size(x,1);        % numero de nos
Neqs=2*Nnds;            % numero total de equacoes ou graus de liberdade

%   inicializacao a zeros
Kg=zeros(Neqs,Neqs)
fg=zeros(Neqs,1)	% declarado como vector coluna

%	Tarefa 54 : Assemblagem de elementos triangulares de 6-nós

for i=1:Nelt        %   ciclo para os elementos
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
  edofs =[no1 no2 no3 no4 no5 no6]  ;  %   conectividade deste triangulo

  %     coordenadas do elemento aqui
  XN(1:6,1)=x(edofs);
  XN(1:6,2)=y(edofs);

% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
    idof1 = (no1-1)*2+1	 %   endereco do primeiro grau de liberdade deste no1
    idof2 = (no2-1)*2+1	 %   endereco do primeiro grau de liberdade deste no2
    idof3 = (no3-1)*2+1  %   endereco do primeiro grau de liberdade deste no3
    idof4 = (no4-1)*2+1  %   endereco do primeiro grau de liberdade deste no4
    idof5 = (no5-1)*2+1  %   endereco do primeiro grau de liberdade deste no5
    idof6 = (no6-1)*2+1  %   endereco do primeiro grau de liberdade deste no6
% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
  edofs=[idof1 idof1+1 idof2 idof2+1 idof3 idof3+1 idof4 idof4+1 idof5 ...
         idof5+1 idof6 idof6+1]  %   guardar estes 12 dofs
%------------------------------------------------------------------------------
  %     calculos neste elemento i
  [Ke fe]= Elem_ElasTRI6 (XN,C,he,0)   %#ok<*NCOMMA> % <- carregamento nulo aqui
  %     assemblagem do elemento i
  Kg(edofs,edofs)= Kg(edofs,edofs) + Ke ;  % 
  fg(edofs,1)= fg(edofs,1) + fe    ;       % 
end %	ciclo for i
%------------------------------------------------------------------------------
Kg	%   ver a matriz global e verificar, por favor

fg	%   ver o vector global e verificar, por favor
%--------------------------------------------------------------------------
%   Tarefa 45 : Inserir aqui condicoes de fronteira naturais
%--------------------------------------------------------------------------
%	Tracoes aplicadas nos nos
%       So ha componentes vericais negativas em 3 nos
no=1
    idof = (no-1)*2+2	 %   endereco do segundo grau de liberdade deste no
    fg(idof,1)= fg(idof,1) - 50;
no=6
    idof = (no-1)*2+2	 %   endereco do segundo grau de liberdade deste no
    fg(idof,1)= fg(idof,1) - 200;
no=11
    idof = (no-1)*2+2	 %   endereco do segundo grau de liberdade deste no
    fg(idof,1)= fg(idof,1) - 50;
%--------------------------------------------------------------------------
%	Atencao: Guardar uma copia do sistema original antes de o modificar
Kr= Kg;
fr= fg;
%   Vamos precisar do sistema original para verificar o equilibrio estatico
%   e Calcular as reacoes nos apoios   
%--------------------------------------------------------------------------
%	formar o sistema equivalente ao sistema reduzido
%	mas sem alterar as suas dimensoes
%--------------------------------------------------------------------------
%   Tarefa 46 - condicoes de fronteira essenciais e apoios deslizantes aqui
%--------------------------------------------------------------------------
boom=1.0e+14;
%   restringir graus de liberdade u (horizontais)
no=5
    idof = (no-1)*2+1	 %   endereco do primeiro grau de liberdade deste no
    Kr(idof,idof) = boom;
    fr(idof,1)= boom*0;
no=10
    idof = (no-1)*2+1	 %   endereco do primeiro grau de liberdade deste no
    Kr(idof,idof) = boom;
    fr(idof,1)= boom*0;
no=15
    idof = (no-1)*2+1	 %   endereco do primeiro grau de liberdade deste no
    Kr(idof,idof) = boom;
    fr(idof,1)= boom*0;
%   restringir graus de liberdade v (verticais)
no=10
    idof = (no-1)*2+2	 %   endereco do segundo grau de liberdade deste no
    Kr(idof,idof) = boom;
    fr(idof,1)= boom*0;
%--------------------------------------------------------------------------
%   Tarefa 47 : seccao para resolver o sistema e
%   controlar o valor maximo
%
Kr=sparse(Kr);	    %	pode usar-se modo sparso para a matriz global
%--------------------------------------------------------------------------
%	solucao do sistema modificado por backslash
u=Kr\fr ;
umx=max(u)
%
%	Tarefa 47 : calcular a resultante e as reacoes nos apoios
%
%   	Verificacao do equilibrio estatico	
%   	Reacoes nos apoios com o sistema original obtido apos assemblagem
R = Kg*u-fg
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   Tarefa 48 : seccao para desenhar a malha de TRI-6 deformada
%--------------------------------------------------------------------------
%
figure
x1 = x + u(1:2:Neqs,1)*500   %   factor de escala apropriado aqui
y1 = y + u(2:2:Neqs,1)*500   %   factor de escala apropriado aqui
plot (x1,y1,'ro'); hold on

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
edofs=[tri6(i,1) tri6(i,4) tri6(i,2) tri6(i,5) tri6(i,3) tri6(i,6) tri6(i,1)] ; 
plot(x1(edofs),y1(edofs),'k');hold on
end
hold off

%   fim da visualizacao da malha
%-----------------------------------------------------
%--------------------------------------------------------------------------
%	Tarefa 49 : Calcular Strain & Stresses em pontos interiores
%--------------------------------------------------------------------------
%   ciclo para os elementos
for i=1:Nelt
Delta=zeros(12,1) %#ok<*PREALL>
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
  edofs =[no1 no2 no3 no4 no5 no6]  ;  %   conectividade deste triangulo
  %     coordenadas do elemento aqui
  XN(1:6,1)=x(edofs);
  XN(1:6,2)=y(edofs);

% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
    idof1 = (no1-1)*2+1	 %   endereco do primeiro grau de liberdade deste no1
    idof2 = (no2-1)*2+1	 %   endereco do primeiro grau de liberdade deste no2
    idof3 = (no3-1)*2+1  %   endereco do primeiro grau de liberdade deste no3
    idof4 = (no4-1)*2+1  %   endereco do primeiro grau de liberdade deste no4
    idof5 = (no5-1)*2+1  %   endereco do primeiro grau de liberdade deste no5
    idof6 = (no6-1)*2+1  %   endereco do primeiro grau de liberdade deste no6
% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
  edofs=[idof1 idof1+1 idof2 idof2+1 idof3 idof3+1 idof4 idof4+1 idof5 ...
         idof5+1 idof6 idof6+1]  %   guardar estes 12 dofs
%------------------------------------------------------------------------------
    Delta=u(edofs)	% definir vector local de dofs ja determinados
%   indicar o centroide
    csi=1/3
    eta=1/3
  %     Stresses neste elemento i
[Stress Strain]=Stress_Strain_TRI6 (XN,C,Delta,csi,eta)
i,Stress(1)
%--------------------------------------------------------------------------
%	Tarefa 50 : Calcular von Mises Stresses em pontos interiores
%--------------------------------------------------------------------------
%       von Mises Stress para deformacao plana
% Sigz= niu*(Stress(1)+Stress(2))
% I1= Stress(1)+Stress(2)+Sigz ;          %   primeiro invariante
% I2= Stress(1)*Stress(2)+Stress(1)*Sigz+Stress(2)*Sigz-Stress(3)^2  ;  %   segundo invariante
%       von Mises Stress para tensao plana
I1= Stress(1)+Stress(2) ;               %   primeiro invariante
I2= Stress(1)*Stress(2)-Stress(3)^2  ;  %   segundo invariante
VMS = sqrt(I1*I1-3*I2)                  %------ von Mises Stress 
%--------------------------------------------------------------------------
end %	ciclo for i
%--------------------------------------------------------------------------

function [Stress Strain]=Stress_Strain_TRI6 (XN,C,Delta,csi,eta)
%--------------------------------------------------------------------------
%   C  - Matriz Elastica para Elasticidade Plana
%--------------------------------------------------------------------------
%
A = zeros(6,2);	% matriz auxiliar A(6x2) das derivadas parciais das
%	funcoes de forma em (x,y) calculada na Shape_N_Der6
%--------------------------------------------------------------------------
%   para cada ponto (csi,eta) dado, calcular a matriz A (6x2) das 
%   derivadas parciais das funcoes de forma em (x,y)      
%------------------------------------------
[A F Detj]=Shape_N_Der6 (XN,csi,eta); %#ok<*ASGLU>
%--------------------------------------------------------------------------
%      forma a matriz B (3x12) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0 A(5,1) 0 A(6,1) 0;0 A(1,2) 0 A(2,2)...
   0 A(3,2) 0 A(4,2) 0 A(5,2) 0 A(6,2); A(1,2) A(1,1) A(2,2) A(2,1) A(3,2)...
   A(3,1) A(4,2) A(4,1) A(5,2) A(5,1) A(6,2) A(6,1)] %#ok<*NOPRT>
%--------------------------------------------------------------------------
Strain = B*Delta
Stress = C*Strain
end

%----------------------------------------------------------------
function [Ke fe]=Elem_ElasTRI6 (XN,C,he,fL) %#ok<*INUSD>
%   Matriz XN(6,2) contem as coordenadas locais deste TRI de 6 nos
%   fL - intensidade da força uniforme  
%   inicializar Ke
 Ke = zeros(12,12);
 A = zeros(6,2);	% matriz auxiliar A(6x2) das derivadas parciais das
%	 funcoes de forma em (x,y)
 F = zeros(6,1);	% vector auxiliar F(6,1) das funcoes de forma

%   gerar os pontos de integracao
nip = 7;
[xp wp]=GenipT (nip);

%   percorrer os pontos de integracao
for ip=1:nip;	 %#ok<*NOSEMI> %	ciclo para os pontos de integracao

csi = xp(ip,1);
eta = xp(ip,2);
%
%   para cada ponto dado, calcular:   
%   a matriz A (6x2) das derivadas parciais das funcoes de forma em (x,y);  
%   funcoes de forma do TRI-6, no vector F(6x1);
%   jacobiano da transformacao, Detj.

[A F Detj]=Shape_N_Der6 (XN,csi,eta);

%      forma a matriz B (3x12) para elasticidade plana
B=[A(1,1) 0 A(2,1) 0 A(3,1) 0 A(4,1) 0 A(5,1) 0 A(6,1) 0;0 A(1,2) 0 A(2,2)...
   0 A(3,2) 0 A(4,2) 0 A(5,2) 0 A(6,2); A(1,2) A(1,1) A(2,2) A(2,1) A(3,2)...
   A(3,1) A(4,2) A(4,1) A(5,2) A(5,1) A(6,2) A(6,1)]

%      forma a matriz Psi (2x12) para elasticidade plana
Psi=[F(1) 0 F(2) 0 F(3) 0 F(4) 0 F(5) 0 F(6) 0;0 F(1) 0 F(2) 0 F(3) 0 ...
     F(4) 0 F(5) 0 F(6)] %#ok<*NASGU>

%   7) peso transformado
wip = he*wp(ip)*Detj;
%   8) calcular produto B'*C*B, pesar e somar a Ke
Ke = Ke + wip*B'*C*B ;
%   9) %   vector de cargas: somar fe aqui quando tiver de ser ;)
%wipf = fL*wip ;
%fe = fe + wipf*Psi ;
fe = zeros(12,1);    %   nao ha body forces
%	proximo ponto
end	%   fim de ciclo de integracao
end
