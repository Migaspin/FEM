function [Kg, fg] = dirichlet(nos, Kg, fg)
    Kg(nos) = 1.0e+16;
    fg(nos) = 0;
end