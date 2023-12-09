function fg = neumann(coordenada, nos, fg, derivada)
    elementos = [coordenada(nos) nos ];
    elementos = sort(elementos);
    elementos = [elementos(:,2) elementos(:,1)];

    for i = 1:(length(elementos) - 1)
        distancia = elementos(i+1, 2) - elementos(i,2);
        forca = derivada / 2 * distancia;
        fg(elementos(i,1)) = fg(elementos(i,1)) + forca;
        fg(elementos(i+1,1)) = fg(elementos(i+1,1)) + forca;
    end
end