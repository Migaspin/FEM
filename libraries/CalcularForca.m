function [forca, forcaX, forcaY] = CalcularForca(x, y, no1, no2, pressao)
    distancia = sqrt((x(no1) - x(no2))^2 + (y(no1) - y(no2))^2);
    forca = pressao * distancia/1000;
    forcaX = (y(no1) - y(no2))/distancia * forca;
    forcaY = (x(no2) - x(no1))/distancia * forca;
end