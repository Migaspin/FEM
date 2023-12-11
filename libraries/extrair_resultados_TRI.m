function extrair_resultados_TRI(nome_ficheiro, x, y, u, tri, vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin)
    ficheiro = fopen(nome_ficheiro, "a");

    data = string(datetime("now"));
    
    formatacao_cabecalho = "===============\nSimulação de %s\n===============";
    formatacao_extremos = "\nVelocidade Máxima: %10.2f Nó: %i\nVelocidade Mínima: %10.2f Nó: %i\nPressão Máxima: %10.2f Nó: %i\nPressão Mínima: %10.2f Nó: %i\n";
    formatacao_nos = "\n===============\n   ->Nó %i:\nCoordenadas: X =  %10.2f Y = %10.2f\nPotencial:   U = %10.2f";
    formatacao_elementos = "\n===============\n   ->Elemento %i:\nNós: %i %i %i\nVelocidade: Vx = %10.2f Vy = %10.2f V = %10.2f\nPressão:    P =  %10.2f";
    
    fprintf(ficheiro, formatacao_cabecalho, data);

    fprintf(ficheiro, formatacao_extremos, vmax, local_vmax, vmin, local_vmin, pmax, local_pmax, pmin, local_pmin);

    for i  = 1:length(x)
        fprintf(ficheiro, formatacao_nos, i, x(i), y(i), u(i));
    end

    for i  = 1:length(tri)
        fprintf(ficheiro, formatacao_elementos, i, tri(i,1), tri(i,2), tri(i,3), vx(i), vy(i), v(i), p(i));
    end

    fclose(ficheiro);
end