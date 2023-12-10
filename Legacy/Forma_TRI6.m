function psi = Forma_TRI6(i, dEpsilon, epsilon,niu)
    % FORMA_TRI6 Devolve a derivada de Psi i sobre dEpsilon ou dNiu num dado ponto (epsilon, niu)
    % i -> int 1 a 6, dEpsilon -> bool, epsilon e niu -> coordenadas de 0 a 1
    if dEpsilon
        switch i
            case i == 1
                psi = 4 * epsilon + 4 * niu - 3;
            case i == 2
                psi = 4 * epsilon - 1;
            case i == 3
                psi = 0;
            case i == 4
                psi = 4 - 8 * epsilon - 4 * niu;
            case i == 5
                psi = 4 * niu;
            case i == 6
                psi = -4 * niu;
            otherwise
                psi = 0;
        end
    else
        switch i
            case i == 1
                psi = 4 * epsilon + 4 * niu - 3;
            case i == 2
                psi = 0;
            case i == 3
                psi = 4 * niu - 1;
            case i == 4
                psi = -4 * epsilon;
            case i == 5
                psi = 4 * epsilon;
            case i == 6
                psi = 4 - 4 * epsilon - 8 * niu;
            otherwise
                psi = 0;
        end
    end
end