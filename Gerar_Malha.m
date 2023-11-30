function [x, y, conectividades] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro)
    % Definição da Formatação dos dados extraidos
    formatacao = "%c"; "%d";

    % Processamento dos nós

    % Importar ficheiro
    nos_ficheiro = fopen(nos_nome_ficheiro, "r");
    nos_bruto = splitlines(fscanf(nos_ficheiro, formatacao));

    % Preparar o array
    nos = strings(round((length(nos_bruto) - 12) / 6 + 1),1);

    % Preencher o array
    for i = 11:6:length(nos_bruto)
        nos((i - 11)/6 + 1) = nos_bruto(i);
    end

    % Selecionar informações necessárias
    coordenadas_nos = split(nos);
    coordenadas_nos = coordenadas_nos(:,5:6);
    
    % Preparar x e y
    x = zeros(length(coordenadas_nos),1);
    y = zeros(length(coordenadas_nos),1);

    % Preencher x e y
    for i = 1:length(coordenadas_nos)
        x(i) = coordenadas_nos(i, 1);
        y(i) = coordenadas_nos(i, 2);
    end

    % Processamento dos elementos

    % Importar ficheiro
    elementos_ficheiro = fopen(elementos_nome_ficheiro, "r");
    elementos_bruto = splitlines(fscanf(elementos_ficheiro, formatacao));

    % Preparar array
    elementos = strings(length(elementos_bruto) - 20,1);

    % Preencher array
    for i = 17:length(elementos_bruto)-4
            elementos(i - 16) = elementos_bruto(i);
    end

    % Selecionar informações necessárias
    conectividades = split(elementos);
    conectividades = str2double(conectividades(:,11:end));
end