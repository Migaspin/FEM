function extrair_erro(nome_ficheiro, erro)
    ficheiro = fopen(nome_ficheiro, "a");
    data = string(datetime("now"));
    
    formatacao_cabecalho = "===============\nErro da Simulação de %s\n===============";
    
    formatacao_erro = "\n===============\n   ->Nó %i:\nErro:   U - u = %10.10f";

    fprintf(ficheiro, formatacao_cabecalho, data);

    for i  = 1:length(erro)
        fprintf(ficheiro, formatacao_erro, i, erro(i));
    end
end