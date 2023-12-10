elementos_nome_ficheiro = "ELEMENTOS.txt";
nos_nome_ficheiro = "NOS.txt";

[x, y, tri] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro);

visualisar_malha_simples(x, y, tri)

[Kg, fg] = Assem_TRI6(x, y, tri);


fg = neumann(y, selecionar_nos(x, -1900), fg, -2500);

Kr = Kg;
fr = fg;

[Kr, fr] = dirichlet(selecionar_nos(x, 1900), 0, Kr, fr);

u = Kr\fr;

visualisar_malha_com_fluxos(x, y, u, tri)
visualisar_malha_solucao(x, y, u, tri)