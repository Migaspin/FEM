function fg = neumann(tri, elementos, nos, fg, derivada)
    vertices = tri(elementos,1:3);
    for i = 1:length(nos)
        if numero_de_instancias(vertices,nos(i)) == 1
            fg(nos(i)) = fg(nos(i)) + derivada / 2;
        else
            fg(nos(i)) = fg(nos(i)) + derivada;
        end
    end
end