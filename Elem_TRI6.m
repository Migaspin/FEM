function [Ke, fe]=Elem_TRI6 (XN,fL)
    % Calcula a Matriz de Rigidez e o Vector das Forças de um Elemento Triangular Quadrático (6 nós)

    % Inicializamos Ke e fe
     Ke = zeros(6,6);
     fe = zeros(6,1);

    % Geramos os pontos de integração
    nip = 7;
    [xp, wp]=GenipT (nip);
    
    % Ciclo que percorre os pontos de integração
    for ip=1:nip

        % Extraimos csi e eta
        csi = xp(ip,1);
        eta = xp(ip,2);

        % Calculamos a matriz B, o vector psi, e o determinante da jacobiana
        [B, psi, ~, Detj] = Shape_N_Der6(XN,csi,eta);
        
        % Calculamos o peso
        wip = wp(ip)*Detj;

        % Ponderamos a Força Local
        wipf = fL*wip;

        % Atualizamos o Vector da Força
        fe = fe + wipf*psi;

        % Atualizamos a Matriz de Rigidez
        Ke = Ke + wip*(B*B');
    end
end
