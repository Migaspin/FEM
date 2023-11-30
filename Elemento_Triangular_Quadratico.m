function [Ke, fe]=Elemento_Triangular_Quadratico (Coordenadas,C,he,fL) %#ok<*INUSD>
    
    % Inicializamos a matriz de rigidez do elemento
    Ke = zeros(12,12);
    
    % Geramos os Pontos de Integração
    numero_de_pontos_de_integracao = 7;
    [coordenada_de_integracao, peso_de_integracao]=Pontos_de_Integracao(numero_de_pontos_de_integracao);

    % Percorrer os pontos de integração
    for ip=1:numero_de_pontos_de_integracao;
    % Coordenadas locais csi e eta, homólogas a x e y
    csi = coordenada_de_integracao(ip,1);
    eta = coordenada_de_integracao(ip,2);
    
    % Calculo das Funções de Forma nos pontos csi e eta
    [Derivadas_das_Funcoes_de_Forma, Funcoes_de_Forma, Determinante_do_Jacobiano] = Shape_N_Der6 (Coordenadas,csi,eta);
    
    %      forma a matriz B (3x12) para elasticidade plana
    B=[Derivadas_das_Funcoes_de_Forma(1,1) 0 Derivadas_das_Funcoes_de_Forma(2,1) 0 Derivadas_das_Funcoes_de_Forma(3,1) 0 Derivadas_das_Funcoes_de_Forma(4,1) 0 Derivadas_das_Funcoes_de_Forma(5,1) 0 Derivadas_das_Funcoes_de_Forma(6,1) 0;0 Derivadas_das_Funcoes_de_Forma(1,2) 0 Derivadas_das_Funcoes_de_Forma(2,2)...
       0 Derivadas_das_Funcoes_de_Forma(3,2) 0 Derivadas_das_Funcoes_de_Forma(4,2) 0 Derivadas_das_Funcoes_de_Forma(5,2) 0 Derivadas_das_Funcoes_de_Forma(6,2); Derivadas_das_Funcoes_de_Forma(1,2) Derivadas_das_Funcoes_de_Forma(1,1) Derivadas_das_Funcoes_de_Forma(2,2) Derivadas_das_Funcoes_de_Forma(2,1) Derivadas_das_Funcoes_de_Forma(3,2)...
       Derivadas_das_Funcoes_de_Forma(3,1) Derivadas_das_Funcoes_de_Forma(4,2) Derivadas_das_Funcoes_de_Forma(4,1) Derivadas_das_Funcoes_de_Forma(5,2) Derivadas_das_Funcoes_de_Forma(5,1) Derivadas_das_Funcoes_de_Forma(6,2) Derivadas_das_Funcoes_de_Forma(6,1)];
    
    %      forma a matriz Psi (2x12) para elasticidade plana
    Psi=[Funcoes_de_Forma(1) 0 Funcoes_de_Forma(2) 0 Funcoes_de_Forma(3) 0 Funcoes_de_Forma(4) 0 Funcoes_de_Forma(5) 0 Funcoes_de_Forma(6) 0;0 Funcoes_de_Forma(1) 0 Funcoes_de_Forma(2) 0 Funcoes_de_Forma(3) 0 ...
         Funcoes_de_Forma(4) 0 Funcoes_de_Forma(5) 0 Funcoes_de_Forma(6)]; %#ok<*NASGU>
    
    %   7) peso transformado
    wip = he*peso_de_integracao(ip)*Determinante_do_Jacobiano;
    %   8) calcular produto B'*C*B, pesar e somar a Ke
    Ke = Ke + wip*B'*C*B ;
    %   9) %   vector de cargas: somar fe aqui quando tiver de ser ;)
    
    %wipf = fL*wip ;
    %fe = fe + wipf*Psi ;

    % Devolvemos um vector força nulo já que não há forças
    fe = zeros(12,1);
    end	
end