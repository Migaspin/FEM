function visualisar_malha_solucao(x, y, u, tri6)
    figure
    Nelt=size(tri6,1) ;
    for i=1:Nelt
        edofs = [tri6(i, 1) tri6(i, 4) tri6(i, 2) tri6(i, 5) tri6(i, 3) tri6(i, 6) tri6(i, 1)]; 
        fill (x(edofs),y(edofs),u(edofs));hold on
        plot(x(edofs),y(edofs),'b');hold on
    end
    plot(x,y,'ro');
    
    figure
    for i=1:Nelt
        edofs = [tri6(i, 1) tri6(i, 4) tri6(i, 2) tri6(i, 5) tri6(i, 3) tri6(i, 6) tri6(i, 1)]; 
        fill3(x(edofs),y(edofs),u(edofs),u(edofs));hold on
        plot(x(edofs),y(edofs),'r');hold on
    end
    plot(x,y,'ro');
end