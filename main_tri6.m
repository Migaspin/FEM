%elementos_nome_ficheiro = "ELEMENTOS.txt";
%nos_nome_ficheiro = "NOS.txt";
elementos_nome_ficheiro = "projetoMComp_elementos_T6.txt";
nos_nome_ficheiro = "projetoMComp_nos_T6.txt";

[x, y, tri6] = Gerar_Malha(elementos_nome_ficheiro, nos_nome_ficheiro);

%visualisar_malha_simples(x, y, tri6)

[Kg, fg] = Assem_TRI6(x, y, tri6);

fg = neumann(selecionar(x, -1900),fg, 2500);

Kr = Kg;
fr = fg;

[Kr, fr] = dirichlet(selecionar_nos(x, 1900), 0, Kr, fr);

u = Kr\fr;

%visualisar_malha_com_fluxos(x, y, u, tri6)
visualisar_malha_solucao(x, y, u, tri6)