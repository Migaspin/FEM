function visualisar_malha_simples(x, y, conectividades)
    % Inicializar o visualisador
    figure

    % Calcular o numero de elementos
    Numero_de_elementos = size(conectividades,1);
    
    % Desenhar todas as conexões entre os nós de cada elemento: 1 -> 4 -> 2 -> 5 -> 3 -> 6 -> 1
    for i = 1:Numero_de_elementos
        nos = [conectividades(i, 1) conectividades(i, 4) conectividades(i, 2) conectividades(i, 5) conectividades(i, 3) conectividades(i, 6) conectividades(i, 1)]; 
        plot(x(nos), y(nos), 'b');hold on
    end

    % Desenhar os nós
    plot(x, y, 'ro');
end