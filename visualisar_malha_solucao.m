function visualisar_malha_solucao(x, y, u, tri)
    % Inicializamos o visualisador
    figure

    % Calculamos o numero de elementos
    Nelt=size(tri,1);

    % Desenhamos todos os triangulos 2D com uma cor correspondente ao valor de u
    for i=1:Nelt
        if length(tri(1)) == 6
            edofs = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            edofs = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        fill (x(edofs),y(edofs),u(edofs));hold on
    end
    
    % Inicializamos o visualisador
    figure

    % Desenhamos todos os triangulos 3D com uma cor e coordenada z correspondente ao valor de u
    for i=1:Nelt
        if length(tri(1)) == 6
            edofs = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            edofs = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        fill3(x(edofs),y(edofs),u(edofs),u(edofs));hold on
    end
end