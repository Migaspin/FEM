function visualisar_malha_solucao(x, y, u, tri6)
    x = x/1000;
    y = y/1000;
    u = u/1000;    
    
    figure
    Nelt=size(tri6,1) ;
    for i=1:Nelt
        edofs = [tri6(i, 1) tri6(i, 4) tri6(i, 2) tri6(i, 5) tri6(i, 3) tri6(i, 6) tri6(i, 1)]; 
        fill (x(edofs),y(edofs),u(edofs));hold on
    end
    
    figure
    for i=1:Nelt
        edofs = [tri6(i, 1) tri6(i, 4) tri6(i, 2) tri6(i, 5) tri6(i, 3) tri6(i, 6) tri6(i, 1)]; 
        fill3(x(edofs),y(edofs),u(edofs),u(edofs));hold on
    end
end