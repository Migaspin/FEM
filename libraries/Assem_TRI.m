function [Kg, fg] = Assem_TRI(x, y, TRI)
    % Executa a Assemblagem de elementos triangulares lineares (3 nós)

    % Calcula o número de elementos
    Nelt=size(TRI,1); 
    
    % Calcula o numero de nós
    Nnds =size(x,1);
    
    % Inicializa a Matriz de Rigidez e o Vector de Forças Globais
    Kg=zeros(Nnds,Nnds);
    fg=zeros(Nnds,1);
    
    % Ciclo que percorre todos os elementos
    for i=1:Nelt
        
        % Define os nós 1, 2 e 3 do elemento, assim como os graus de liberdade
        no1 = TRI(i, 1);
        no2 = TRI(i, 2);
        no3 = TRI(i, 3);
        edofs =TRI(i,1:3);
        
        % Calcula a Matriz de Rigidez e o Vector de Forças do Elemento
        [Ke, fe]= Elem_TRI (x(no1),y(no1),x(no2),y(no2),x(no3),y(no3));
        
        % Soma a Matriz de Rigidez e o Vector de Forças do Elemento à Matriz de Rigidez e ao Vector de Forças Globais (Assemblagem)
        Kg(edofs,edofs)= Kg(edofs,edofs) + Ke;
        fg(edofs,1)= fg(edofs,1) + fe;
    end
end