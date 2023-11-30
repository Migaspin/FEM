function [X, Y, conectividades] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro)
    formatacao = "%c"; "%d";

    elementos_ficheiro = fopen(elementos_nome_ficheiro, "r");
    nos_ficheiro = fopen(nos_nome_ficheiro, "r");

    elementos_bruto = splitlines(fscan(elementos_ficheiro, formatacao));
    nos_bruto = splitlines(fscan(nos_ficheiro, formatacao));
    
    % Processamento dos nós
    
    % Selecionamos apenas as linhas com as coordeandas
    for i = 11:6:length(nos_bruto)
        nos = [nos_bruto, nos_bruto(i)];
    end

    nos = nos';

    % Tiramos as 
    coordenadas_nos = split(nos);
    coordenadas_nos = coordenadas_nos(5, 6);

    X = zeroes(length(coordenadas_nos));
    Y = zeroes(length(coordenadas_nos));

    for i = 1:length(coordenadas_nos)
        X(i) = coordenadas_nos(i, 1);
        Y(i) = coordenadas_nos(i, 2);
    end


end