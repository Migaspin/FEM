% Nós para o T6
x = [0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4 0 1 2 3 4]'
y = [0 0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4]'

conectividades = [1 3 11 2 7 6; 3 13 11 8 12 7]

figure
Numero_de_elementos=size(conectividades,1) ; 
for i=1:Numero_de_elementos
    edofs=[conectividades(i,1) conectividades(i,4) conectividades(i,2) conectividades(i,5) conectividades(i,3) conectividades(i,6)]; 
    plot(x(edofs),y(edofs),'b');hold on
end
plot(x,y,'ro');

[x, y, conectividades] = Malha_Uniforme(5, 5, 5, 5)

figure
Numero_de_elementos=size(conectividades,1) ; 
for i=1:Numero_de_elementos
    edofs=[conectividades(i,1) conectividades(i,4) conectividades(i,2) conectividades(i,5) conectividades(i,3) conectividades(i,6)]; 
    plot(x(edofs),y(edofs),'b');hold on
end
plot(x,y,'ro');