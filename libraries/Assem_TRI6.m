function [Kg, fg] = Assem_TRI6(x, y, tri6)
    % Executa a Assemblagem de elementos triangulares quadraticos (6 n�s)

    % Calcula o n�mero de elementos
    Nelt=size(tri6,1);
    
    % Calcula o numero de n�s
    Nnds =size(x,1);
    
    % Inicializa a Matriz de Rigidez e o Vector de For�as Globais
    Kg=zeros(Nnds,Nnds); 
    fg=zeros(Nnds,1);

    % Ciclo que percorre todos os elementos
    for i=1:Nelt
        
        % Define os n�s 1, 2, 3, 4, 5 e 6 do elemento, assim como os graus de liberdade
        no1=tri6(i,1); 
        no2=tri6(i,2); 
        no3=tri6(i,3); 
        no4=tri6(i,4); 
        no5=tri6(i,5); 
        no6=tri6(i,6);
        edofs =[no1 no2 no3 no4 no5 no6];

        % Extrai as coordenadas dos n�s do elemento
        XN(1:6,1)=x(edofs);
        XN(1:6,2)=y(edofs);

        % Define a for�a local como 0, de acordo com o problema a resolver
        fL= 0.0;

        % Calcula a Matriz de Rigidez e o Vector de For�as do Elemento
        [Ke, fe]=Elem_TRI6 (XN,fL) ;

        % Soma a Matriz de Rigidez e o Vector de For�as do Elemento � Matriz de Rigidez e ao Vector de For�as Globais (Assemblagem)
        Kg(edofs,edofs)= Kg(edofs,edofs) + Ke ;
        fg(edofs,1)= fg(edofs,1) + fe;
    end
end