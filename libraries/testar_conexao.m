function value = testar_conexao(no1, no2, tri)
    [i, ~] = find(tri == no1); 
    value = any(tri(i,:) == no2);
end