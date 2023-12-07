function [Kg, fg] = Assem_TRI6(x, y, tri6)

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
[Ke, fe]=Elem_TRI6 (XN,fL) ; 

  %     assemblagem
  Kg(edofs,edofs)= Kg(edofs,edofs) + Ke  ;  % 
  fg(edofs,1)= fg(edofs,1) + fe     ;       % 
end %for i
end