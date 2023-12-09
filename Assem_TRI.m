function [Kg, fg] = Assem_TRI(x, y, TRI)
Nelt=size(TRI,1); 

Nnds =size(x,1);

Kg=zeros(Nnds,Nnds);
fg=zeros(Nnds,1);

for i=1:Nelt
    no1 = TRI(i,1);
    no2 = TRI(i,2);
    no3 = TRI(i,3);
  edofs =[no1 no2 no3];

  [Ke, fe]= Elem_TRI (x(no1),y(no1),x(no2),y(no2),x(no3),y(no3));

  Kg(edofs,edofs)= Kg(edofs,edofs) + Ke;
  fg(edofs,1)= fg(edofs,1) + fe;
end
end