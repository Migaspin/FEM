function visualisar_malha_simples(x, y, tri)
    % Inicializamos o visualisador
    figure

    % Calculamos o numero de elementos
    Numero_de_elementos = size(tri,1);
    
    % Desenhamos todas as conexões entre os nós de cada elemento: 1 -> 4 -> 2 -> 5 -> 3 -> 6 -> 1
    for i = 1:Numero_de_elementos
        if length(tri(1,:)) == 6
            nos = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            nos = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        plot(x(nos), y(nos), 'b');hold on
    end

    % Desenhamos os nós
    plot(x(tri), y(tri), 'ro');
end