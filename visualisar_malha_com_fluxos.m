function visualisar_malha_com_fluxos(x, y, u, tri)
    % Inicializamos o visualisador
    figure

    % Calculamos o numero de elementos
    Numero_de_elementos = size(tri,1);

    % Inicializamos vectores dos centroides e fluxos
    xm = zeros(Numero_de_elementos);
    ym = zeros(Numero_de_elementos);
    um = zeros(Numero_de_elementos);
    vm = zeros(Numero_de_elementos);

    % Desenhamos todas as conexões entre os nós de cada elemento: 1 -> 4 -> 2 -> 5 -> 3 -> 6 -> 1
    for i = 1:Numero_de_elementos
        if length(tri(1)) == 6
            nos = [tri(i, 1) tri(i, 4) tri(i, 2) tri(i, 5) tri(i, 3) tri(i, 6) tri(i, 1)];
        else
            nos = [tri(i, 1) tri(i, 2) tri(i, 3) tri(i, 1)];
        end
        plot(x(nos), y(nos), 'b');hold on
        
        % Extraimos o número do nó, o seu X e Y para calcular o centroide
        no1 = tri(i,1);
        no2 = tri(i,2);
        no3 = tri(i,3);

        x1 = x(tri(i, 1));
        x2 = x(tri(i, 2));
        x3 = x(tri(i, 3));

        y1 = y(tri(i, 1));
        y2 = y(tri(i, 2));
        y3 = y(tri(i, 3));

        % Calculamos o centroide
        xm(i) = (x1+x2+x3)/3.;
        ym(i) = (y1+y2+y3)/3.;

        % Calculamos o vector gradiente
        Ae2 = (x2 -x1)*(y3 -y1) -(y2 -y1)*(x3 -x1);

        % Calculamos as derivadas parciais das funções de forma
        d1dx = (y2-y3)/Ae2;
        d1dy = (x3-x2)/Ae2;
        d2dx = (y3-y1)/Ae2;
        d2dy = (x1-x3)/Ae2;
        d3dx = (y1-y2)/Ae2;
        d3dy = (x2-x1)/Ae2;

        % Calculamos as interpolações
        um(i) = (d1dx*u(no1)+d2dx*u(no2)+d3dx*u(no3));
        vm(i) = (d1dy*u(no1)+d2dy*u(no2)+d3dy*u(no3));
    end

    % Desenhamos os nós
    plot(x, y, 'ro');

    % Desenhamos os fluxos
    set(quiver(xm,ym,um,vm,'k'),'AutoScale','on', 'AutoScaleFactor', 5)
end