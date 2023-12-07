function [Kg, fg] = Assemblagem_Triangular_Quadratica(x, y, tri6)
Nelt=size(tri6,1) ; 
Nnds =size(x,1);        % numero de nos
Neqs=2*Nnds;            % numero total de equacoes ou graus de liberdade
%   inicializacao a zeros
Kg=zeros(Neqs,Neqs);
fg=zeros(Neqs,1)	;% declarado como vector coluna

for i=1:Nelt        %   ciclo para os elementos
    no1=tri6(i,1) ; 
    no2=tri6(i,2) ; 
    no3=tri6(i,3) ; 
    no4=tri6(i,4) ; 
    no5=tri6(i,5) ; 
    no6=tri6(i,6) ; 
  edofs =[no1 no2 no3 no4 no5 no6]  ;  %   conectividade deste triangulo

  XN(1:6,1)=x(edofs) ;
  XN(1:6,2)=y(edofs) ;

% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
    idof1 = (no1-1)*2+1	; %   endereco do primeiro grau de liberdade deste no1
    idof2 = (no2-1)*2+1	; %   endereco do primeiro grau de liberdade deste no2
    idof3 = (no3-1)*2+1;  %   endereco do primeiro grau de liberdade deste no3
    idof4 = (no4-1)*2+1;  %   endereco do primeiro grau de liberdade deste no4
    idof5 = (no5-1)*2+1;  %   endereco do primeiro grau de liberdade deste no5
    idof6 = (no6-1)*2+1;  %   endereco do primeiro grau de liberdade deste no6
% --- atencao a isto: dofs em blocos de 2 por cada no -------------------------
  edofs=[idof1 idof1+1 idof2 idof2+1 idof3 idof3+1 idof4 idof4+1 idof5 ...
         idof5+1 idof6 idof6+1];  %   guardar estes 12 dofs
%------------------------------------------------------------------------------
  %     calculos neste elemento i
  [Ke, fe]= Elemento_Triangular_Quadratico(XN); % <- carregamento nulo aqui
  %     assemblagem do elemento i
  Kg(edofs,edofs)= Kg(edofs,edofs) + Ke ;  % 
  fg(edofs,1)= fg(edofs,1) + fe    ;       % 
end %	ciclo for i