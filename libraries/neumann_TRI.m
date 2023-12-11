function fg = neumann_TRI(coordenada, nos, fg, derivada)
    % Organizamos o vector dos elementos 
    elementos = [coordenada(nos) nos ];
    elementos = sortrows(elementos);
    elementos = [elementos(:,2) elementos(:,1)];
    
    % Ciclo que percorre todos os elementos excepto o último
    for i = 1:(length(elementos) - 1)

        % Calculamos a distância entre os dois nós
        distancia = elementos(i+1, 2) - elementos(i,2);
        
        % Atualizamos o Vector de Força
        fg(elementos(i,1)) = fg(elementos(i,1)) + derivada / 2 * distancia;
        fg(elementos(i+1,1)) = fg(elementos(i+1,1)) + derivada / 2 * distancia;

        % Não atualizamos o último elemento visto que este ciclo calcula a força para o elemento atual e o próximo, logo só precisamos de o correr até ao penultimo
    end
end