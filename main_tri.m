elementos_nome_ficheiro = "projetoMComp_elementos_T3.txt";
nos_nome_ficheiro = "projetoMComp_nos_T3.txt";

[x, y, tri] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro);

%visualisar_malha_simples(x, y, tri)

[Kg, fg] = Assem_TRI(x, y, tri);

fg = neumann(selecionar(x, -1900),fg, 2500);

Kr = Kg;
fr = fg;

[Kr, fr] = dirichlet(selecionar(x, 1900), 0, Kr, fr);

u = Kr\fr;

%visualisar_malha_com_fluxos(x, y, u, tri)
visualisar_malha_solucao(x, y, u, tri)