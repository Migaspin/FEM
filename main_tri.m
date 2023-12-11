% Nomes dos ficheiros com os dados para a malha
elementos_nome_ficheiro = "projetoMComp_elementos_T3.txt";
nos_nome_ficheiro = "projetoMComp_nos_T3.txt";

% Geração da malha a partir dos ficheiros
[x, y, tri] = gerar_malha(elementos_nome_ficheiro, nos_nome_ficheiro);

% Visualização da malha gerada
%visualisar_malha_simples(x, y, tri)

% Assemblagem da malha 
[Kg, fg] = Assem_TRI(x, y, tri);

% Aplicação da condição de fronteira de Neumann
fg = neumann_TRI(y, selecionar_nos(x, -1900), fg, -2500);

% Malha original guardada
Kr = Kg;
fr = fg;

% Aplicação da condição de fronteira de Dirichlet
[Kr, fr] = dirichlet(selecionar_nos(x, 1900), 0, Kr, fr);

% Resolução do SEL
u = Kr\fr;

[vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin] = velocidade_e_pressao_TRI(x, y, u, tri);

% Visualização do fluxo e dos resultados em 2D e 3D
visualisar_malha_simples(x, y, tri, false)
visualisar_malha_solucao(x, y, u, tri);
visualisar_malha_com_velocidade(x, y, vx, vy, tri);
visualisar_pressao(x, y, p, tri);


% Extraimos os resultados para análise
extrair_resultados_TRI("resultados_tri3.txt", x, y, u, tri, vx, vy,v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin)