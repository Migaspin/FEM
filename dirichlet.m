function [Kg, fg] = dirichlet(nos, valor, Kg, fg)
    boom = 1.0e+12;
    for i = 1:length(nos)
        Kg(nos(i), nos(i)) = boom;
    end
    fg(nos) = valor * boom;
end