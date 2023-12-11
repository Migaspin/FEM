function u = parametrizacao(x, y, X, Y, U)
    u = spline([X; Y; U])
end