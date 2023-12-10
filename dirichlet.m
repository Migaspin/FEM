function [Kg, fg] = dirichlet(nos, valor, Kg, fg)
    % Definição de uma variavel boom
    boom = 1.0e+12;

    % Ciclo que passa por todos os nós afectados
    for i = 1:length(nos)
        Kg(nos(i), nos(i)) = boom; % O efeito aplicado é o de uma mola com rigidez quase infinita
    end
    fg(nos) = valor * boom; % Aplicado o mesmo efeito no vector das forças

    % Assim, quando se somar todos os valores de Kg * u / boom = fg / boom, vamos ter que 1 * u = valor
    
end