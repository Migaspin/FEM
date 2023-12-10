function [vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin] = velocidade_e_pressao_TRI6(x, y, u, tri)
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

        % Calculamos as derivadas parciais das funções de forma
        [~, ~, dPsi, ~] = Shape_N_Der6([x(tri(i,:)), y(tri(i,:))],1/3, 1/3);

        vx(i) = dPsi(1,1)*u(tri(i,1))+dPsi(2,1)*u(tri(i,2))+dPsi(3,1)*u(tri(i,3))+dPsi(4,1)*u(tri(i,4))+dPsi(5,1)*u(tri(i,5))+dPsi(6,1)*u(tri(i,6));
        vy(i) = dPsi(1,2)*u(tri(i,1))+dPsi(2,2)*u(tri(i,2))+dPsi(3,2)*u(tri(i,3))+dPsi(4,2)*u(tri(i,4))+dPsi(5,2)*u(tri(i,5))+dPsi(6,2)*u(tri(i,6));
    end

    % Calculamos a velocidade absoluta, maxima, e minima
    v = sqrt(vx.^2 + vy.^2);
    vmax = max(v);
    local_vmax = find(v==vmax);
    vmin = min(v);
    local_vmin = find(v==vmin);
    
    % Calculamos a pressão, maxima e minima
    p = p0 + 0.5 * ro * (v_inicial^2) - 0.5 * ro * v.^2;
    pmax = max(p);
    local_pmax = find(p == pmax);
    pmin = min(p);
    local_pmin = find(p == pmin);
end