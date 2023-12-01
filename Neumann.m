function fe = Neumann(x, y, fe)
    % Encontrar fronteira
    [baixo, cima] = bounds(y, "all");
    [esquerda, direita] = bounds(x, "all");

    % Definir limites à esqueda
    nos = find(x == esquerda);
    fe(nos) = -2.5;
    
    % Definir limites superiores e inferiores
    nos = [find(y == baixo) find(y == cima)];
    fe(nos) = 0;
end