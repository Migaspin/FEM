function extrair_resultados(nome_ficheiro, x, y, u, vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin)
    ficheiro = fopen(nome_ficheiro, "a");
    nos = 1:length(x);
    data = string(datetime("now"));
    
    formatacao_cabecalho = "===============\nSimulação de %s\n===============";
    formatacao_extremos = "\nVelocidade Máxima: %5.2f Nó: %i\nVelocidade Mínima: %5.2f Nó: %i\nPressão Máxima: %5.2f Nó: %i\nPressão Mínima: %5.2f Nó: %i\n";
    formatacao_nos = "\n===============\n   ->Nó %i:\nCoordenadas: X = %5.2f Y = %5.2f\nPotencial: U = %5.2f\nVelocidade: Vx = %5.2f Vy = %5.2f V = %5.2f\nPressão: P = %5.2f";
    
    
    fprintf(ficheiro, formatacao_cabecalho, data);
    fprintf(ficheiro, formatacao_extremos, vmax, local_vmax, vmin, local_vmin, pmax, local_pmax, pmin, local_pmin);
    fprintf(ficheiro, formatacao_nos, nos, x, y, u, vx, vy, v, p);
    
    fclose(ficheiro);
end