function instancias = numero_de_instancias(matriz, numero)
    instancias = 0;
    for i = 1:length(matriz)
        for j = 1:length(matriz(1))
            if matriz(i,j) == numero
                instancias = instancias + 1;
            end
        end
    end
end