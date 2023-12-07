elementos_nome_ficheiro = "ELEMENTOS.txt";

nos_nome_ficheiro = "NOS.txt";

[x, y, tri6] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro);

visualisar_malha_simples(x, y, tri6)

[Kg, fg] = Assemblagem_Triangular_Quadratica(x, y, tri6);

fg = neumann(selecionar(x, -1900),fg,-2500);

Kr = Kg;
fr = fg;

[Kr, fr] = dirichlet(selecionar(x, 1900), Kr, fr);

u = Kr\fr;

visualisar_malha_com_fluxos(x, y, tri6, u)