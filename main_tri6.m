% Nomes dos ficheiros com os dados para a malha
elementos_nome_ficheiro = "projetoMComp_elementos_T6.txt";
nos_nome_ficheiro = "projetoMComp_nos_T6.txt";

% Geração da malha a partir dos ficheiros
[x, y, tri] = gerar_malha(elementos_nome_ficheiro, nos_nome_ficheiro);

% Visualização da malha gerada
visualisar_malha_simples(x, y, tri)

% Assemblagem da malha 
[Kg, fg] = Assem_TRI6(x, y, tri);

% Aplicação da condição de fronteira de Neumann
fg = neumann(y, selecionar_nos(x, -1900), fg, 2500);

% Malha original guardada
Kr = Kg;
fr = fg;

% Aplicação da condição de fronteira de Dirichlet
[Kr, fr] = dirichlet(selecionar_nos(x, 1900), 0, Kr, fr);

% Resolução do SEL
u = Kr\fr;

% Visualização do fluxo e dos resultados em 2D e 3D
visualisar_malha_com_fluxos(x, y, u, tri)
visualisar_malha_solucao(x, y, u, tri)