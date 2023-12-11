% Nomes dos ficheiros com os dados para a malha
elementos_nome_ficheiro = "projetoMComp_elementos_T6.txt";
nos_nome_ficheiro = "projetoMComp_nos_T6.txt";

% Geração da malha a partir dos ficheiros
[x, y, tri] = gerar_malha(elementos_nome_ficheiro, nos_nome_ficheiro);

% Assemblagem da malha 
[Kg, fg] = Assem_TRI6(x, y, tri);

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

%extrair_resultados_TRI("resultados_tri6.txt", x, y, u, tri, vx, vy,v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin)