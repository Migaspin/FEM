% Adicionar diretorio com código auxiliar
addpath(genpath("libraries"))

% Nomes dos ficheiros com os dados para a malha
elementos_nome_ficheiro = "Input Data\ELEMENTOS.txt";
nos_nome_ficheiro = "Input Data\NOS.txt";

% Geração da malha a partir dos ficheiros
[x, y, tri] = gerar_malha(elementos_nome_ficheiro, nos_nome_ficheiro);

% Assemblagem da malha 
[Kg, fg] = Assem_TRI6(x, y, tri);

% Aplicação da condição de fronteira de Neumann
fg = neumann_TRI6(y, selecionar_nos(x, -1900), fg, 2500);

% Malha original guardada
Kr = Kg;
fr = fg;

% Aplicação da condição de fronteira de Dirichlet
[Kr, fr] = dirichlet(selecionar_nos(x, 1900), 0, Kr, fr);

% Resolução do SEL
u = Kr\fr;

% Calculamos a velocidade e a pressão
[vx, vy, v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin] = velocidade_e_pressao_TRI6(x, y, u, tri);

% Definimos a solução analítica
U = @(X,Y) 2500 * X - 4750000;

% Calculamos o erro
erro = U(x, y) - u;

% Visualização da malha, dos resultados em 2D e 3D, velocidade, pressao, e erro
visualisar_malha_simples(x, y, tri, true)
visualisar_malha_solucao(x, y, u, tri);
visualisar_malha_com_velocidade(x, y, vx, vy, tri);
visualisar_pressao(x, y, p, tri);
visualisar_malha_solucao(x, y, erro, tri)


% Extraimos os resultados para análise
extrair_resultados_TRI6("Output Data\resultados_test.txt", x, y, u, tri, vx, vy,v, vmax, local_vmax, vmin, local_vmin, p, pmax, local_pmax, pmin, local_pmin)
extrair_erro("Output Data\resultados_test.txt", erro)