function nos = selecionar_nos(coordenada, valor_desejado)
    % Selecionamos todos os nós que se encontram na coordenada desejada
    nos = find(coordenada == valor_desejado);
end