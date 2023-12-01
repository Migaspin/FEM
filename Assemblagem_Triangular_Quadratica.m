function [Kg, fg] = Assemblagem_Triangular_Quadratica(x, y, conectividades)
    % Calcular o número de elementos e nós
    numero_de_elementos = size(conectividades, 1);
    numero_de_nos = size(x, 1);

    % Inicializar Kg e fg
    Kg = zeros(numero_de_nos, numero_de_nos);
    fg = zeros(numero_de_nos, 1);

    % Assemblagem
    for e = 1:numero_de_elementos
        % Selecionar as coordenadas dos nós do elemento e
        coordenadas = [x(conectividades(e,:)), y(conectividades(e,:))];
        
        %Calcular Ke e fe
        [Ke, fe] = Elemento_Triangular_Quadratico(coordenadas);

        for i = 1:6
            I = conectividades(e, i);
            for j = 1:6
                J = conectividades(e, j);
                Kg(I, J) = Kg(I, J) + Ke(i, j);
            end
            fg(I) = fg(I) + fe(i);
        end
    end
end