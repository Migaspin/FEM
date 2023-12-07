function [Ke, fe]=Elemento_Triangular_Quadratico (Coordenadas)
    % Calcular a Matriz C dos coeficientes
    C = [1 0 0; 0 1 0; 0 0 0];

    % Inicializar a matriz de rigidez do elemento
    Ke = zeros(12,12);
    
    % Geramos os Pontos de Integração
    numero_de_pontos_de_integracao = 7;
    [coordenada_de_integracao, peso_de_integracao]=Pontos_de_Integracao(numero_de_pontos_de_integracao);

    % Percorrer os pontos de integração
    for i = 1:numero_de_pontos_de_integracao
        % Coordenadas locais csi e eta, homólogas a x e y
        csi = coordenada_de_integracao(i,1);
        eta = coordenada_de_integracao(i,2);
        
        % Calcular Funções de Forma e as Suas Derivadas e o Jacobiano nos pontos csi e eta
        [Derivadas_das_Funcoes_de_Forma, ~, Determinante_do_Jacobiano] = Shape_N_Der6 (Coordenadas,csi,eta);
        
        % Calcular a matriz B das derivadas das Funções de Forma
        B=[Derivadas_das_Funcoes_de_Forma(1,1) 0 Derivadas_das_Funcoes_de_Forma(2,1) 0 Derivadas_das_Funcoes_de_Forma(3,1) 0 Derivadas_das_Funcoes_de_Forma(4,1) 0 Derivadas_das_Funcoes_de_Forma(5,1) 0 Derivadas_das_Funcoes_de_Forma(6,1) 0;0 Derivadas_das_Funcoes_de_Forma(1,2) 0 Derivadas_das_Funcoes_de_Forma(2,2)...
           0 Derivadas_das_Funcoes_de_Forma(3,2) 0 Derivadas_das_Funcoes_de_Forma(4,2) 0 Derivadas_das_Funcoes_de_Forma(5,2) 0 Derivadas_das_Funcoes_de_Forma(6,2); Derivadas_das_Funcoes_de_Forma(1,2) Derivadas_das_Funcoes_de_Forma(1,1) Derivadas_das_Funcoes_de_Forma(2,2) Derivadas_das_Funcoes_de_Forma(2,1) Derivadas_das_Funcoes_de_Forma(3,2)...
           Derivadas_das_Funcoes_de_Forma(3,1) Derivadas_das_Funcoes_de_Forma(4,2) Derivadas_das_Funcoes_de_Forma(4,1) Derivadas_das_Funcoes_de_Forma(5,2) Derivadas_das_Funcoes_de_Forma(5,1) Derivadas_das_Funcoes_de_Forma(6,2) Derivadas_das_Funcoes_de_Forma(6,1)];

        % Atualizar Ke
        Ke = Ke + peso_de_integracao(i) * Determinante_do_Jacobiano * B' * C * B;
    end

    % Devolvemos um vetor de Força nulo já que não há forças
    fe = zeros(12,1);
end