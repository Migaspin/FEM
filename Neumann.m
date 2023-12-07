function fg = neumann(nos, fg, derivada)
    gama = derivada / length(nos);
    fg(nos) = fg(nos) + gama;
end