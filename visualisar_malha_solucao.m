function visualisar_malha_solucao(x, y, u, tri)
    x = x/1000;
    y = y/1000;
    u = u/1000;    
    
    figure
    Nelt=size(tri,1) ;
    for i=1:Nelt
        if length(tri(1)) == 6
            edofs = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            edofs = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        fill (x(edofs),y(edofs),u(edofs));hold on
    end
    
    figure
    for i=1:Nelt
        if length(tri(1)) == 6
            edofs = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            edofs = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        fill3(x(edofs),y(edofs),u(edofs),u(edofs));hold on
    end
end