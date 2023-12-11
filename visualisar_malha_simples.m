function visualisar_malha_simples(x, y, tri, numeros_dos_elementos_e_nos)
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
        
        if numeros_dos_elementos_e_nos
            for j = 1:length(nos)
                text(x(nos(j)) + 40, y(nos(j)) + 40, horzcat(num2str(nos(j))), "fontsize", 7.5)
            end
    
            xm = (x(nos(1)) + x(nos(3)) + x(nos(5))) / 3;
            ym = (y(nos(1)) + y(nos(3)) + y(nos(5))) / 3;
            text(xm, ym, horzcat(num2str(i)), "fontsize", 10)
        end

        plot(x(nos), y(nos), 'b');hold on
    end

    % Desenhamos os nós
    plot(x(tri), y(tri), 'ro');
end