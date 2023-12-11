function [vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin] = velocidade_e_pressao_TRI(x, y, u, tri)
    % Calculamos o numero de elementos
    Numero_de_elementos = size(tri,1);
    
    % Variaveis diversas
    p0 = 101325; % Pressão atmosférica
    ro = 1000; % Densidade do líquido
    v_inicial = 2.5;% Velocidade inicial

    % Inicializamos as variaveis
    vx = zeros(Numero_de_elementos,1);
    vy = zeros(Numero_de_elementos,1);

    for i = 1:Numero_de_elementos
        
        % Extraimos os nós
        no1 = tri(i,1);
        no2 = tri(i,2);
        no3 = tri(i,3);
        x1 = x(tri(i, 1));
        x2 = x(tri(i, 2));
        x3 = x(tri(i, 3));
        y1 = y(tri(i, 1));
        y2 = y(tri(i, 2));
        y3 = y(tri(i, 3));
        
        % Calculamos as derivadas parciais das funções de forma
        Ae2 = (x2 -x1)*(y3 -y1) -(y2 -y1)*(x3 -x1);

        d1dx = (y2-y3)/Ae2;
        d1dy = (x3-x2)/Ae2;
        d2dx = (y3-y1)/Ae2;
        d2dy = (x1-x3)/Ae2;
        d3dx = (y1-y2)/Ae2;
        d3dy = (x2-x1)/Ae2;

        vx(i) = (d1dx * u(no1) + d2dx * u(no2) + d3dx * u(no3));
        vy(i) = (d1dy * u(no1) + d2dy * u(no2) + d3dy * u(no3));
    end

    % Calculamos a velocidade absoluta, maxima, e minima
    v = sqrt(vx.^2 + vy.^2);
    vmax = max(v);
    local_vmax = find(v==vmax);
    vmin = min(v);
    local_vmin = find(v==vmin);
    
    % Calculamos a pressão, maxima e minima
    p = p0 + 0.5 * ro * (v_inicial^2) - 0.5 * ro * (v./1000).^2;
    pmax = max(p);
    local_pmax = find(p == pmax);
    pmin = min(p);
    local_pmin = find(p == pmin);
end