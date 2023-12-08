function fg = neumann(nos, fg, derivada)
    gama = derivada *0.8/2;
    fg(nos) = fg(nos) + gama;
end