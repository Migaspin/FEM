function [Kg, fg] = dirichlet(nos, Kg, fg)
    Kg(nos) = 1.0e+50;
    fg(nos) = 0;
end