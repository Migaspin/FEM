function fg = neumann_TRI6(coordenada, nos, fg, derivada)
    % Organizamos o vector dos elementos 
    nos_e_coordenadas = [coordenada(nos) nos];
    nos_e_coordenadas = sort(nos_e_coordenadas);
    nos_e_coordenadas = [nos_e_coordenadas(:,2) nos_e_coordenadas(:,1)];
    
    % Ciclo que percorre todos os elementos excepto o último
    for i = 1:((length(nos_e_coordenadas) - 1)/2)
        
        endereco = i*2-1;

        % Calculamos a distância entre os dois nós
        distancia = nos_e_coordenadas(endereco + 2, 2) - nos_e_coordenadas(endereco,2);

        % Atualizamos o Vector de Força
        fg(nos_e_coordenadas(endereco,1)) = fg(nos_e_coordenadas(endereco,1)) + derivada / 6 * distancia;
        fg(nos_e_coordenadas(endereco + 1,1)) = fg(nos_e_coordenadas(endereco + 1,1)) + 4 * derivada / 6 * distancia;
        fg(nos_e_coordenadas(endereco + 2,1)) = fg(nos_e_coordenadas(endereco + 2,1)) + derivada / 6 * distancia;
    end
end