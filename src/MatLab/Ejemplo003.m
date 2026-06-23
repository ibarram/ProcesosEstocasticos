clc;        % Limpiar la ventana de comandos
clear all;  % Eliminar todas las variables del espacio de trabajo

% --- Datos de entrada ---
% Vector de observaciones con valores repetidos
x = [1, 1, 1, 2, 2, 2, 2, 3, 3, 4];

n = length(x);    % Número total de observaciones: n = 10
g = unique(x);    % Valores únicos (clases) en orden ascendente: g = [1, 2, 3, 4]
k = length(g);    % Número de clases distintas: k = 4

% ===============================================================
% MÉTODO 1: Conteo mediante doble bucle anidado
% Para cada clase g(i1) recorre todo el vector x e incrementa
% el contador cuando encuentra una coincidencia
% ===============================================================
n_1 = zeros(1, k);      % Inicializar vector de frecuencias absolutas
for i1 = 1:k
    n_1(i1) = 0;        % Reiniciar contador de la clase i1
    for i2 = 1:n
        if(x(i2) == g(i1))          % Si la observación pertenece a la clase i1
            n_1(i1) = n_1(i1) + 1;  % Incrementar su frecuencia absoluta
        end
    end
end
% Resultado: n_1 = [3, 4, 2, 1]

% ===============================================================
% MÉTODO 2: Conteo mediante find()
% find() devuelve los índices donde se cumple la condición;
% length() de ese resultado equivale al conteo de coincidencias
% ===============================================================
n_2 = zeros(1, k);      % Inicializar vector de frecuencias absolutas
for i1 = 1:k
    n_2(i1) = length(find(x == g(i1)));  % Número de posiciones donde x == g(i1)
end
% Resultado: n_2 = [3, 4, 2, 1]  (idéntico a n_1)

% ===============================================================
% MÉTODO 3: Conteo mediante sum() sobre vector lógico
% (x == g(i1)) genera un vector booleano; sum() cuenta los TRUE
% ===============================================================
n_3 = zeros(1, k);      % Inicializar vector de frecuencias absolutas
for i1 = 1:k
    n_3(i1) = sum(x == g(i1));   % Suma de unos donde x coincide con g(i1)
end
% Resultado: n_3 = [3, 4, 2, 1]  (idéntico a n_1 y n_2)

% ===============================================================
% MÉTODO 4: Conteo vectorizado sin bucles (broadcasting matricial)
% Se construye una matriz de comparación:
%   - x' es un vector columna (n×1)
%   - ones(n,1)*g replica g en n filas → matriz (n×k)
%   - x'*ones(1,k) replica x' en k columnas → matriz (n×k)
% La igualdad elemento a elemento produce una matriz booleana (n×k)
% sum(...) a lo largo de las filas (dim=1, por defecto) cuenta
% cuántas veces aparece cada clase: resultado es vector fila (1×k)
% ===============================================================
% Línea alternativa equivalente (comentada):
% n_4 = sum((g'*ones(1,n))==(ones(k,1)*x),2);  % Opera por filas (dim=2)
n_4 = sum((x' * ones(1,k)) == (ones(n,1) * g));
% Resultado: n_4 = [3, 4, 2, 1]  (idéntico a los métodos anteriores)

% ===============================================================
% COEFICIENTE MULTINOMIAL (número de arreglos distinguibles)
% Dado un conjunto de n elementos donde la clase i se repite n_i
% veces, el número de permutaciones distinguibles es:
%
%        n!
%   ─────────────────  =  10! / (3! · 4! · 2! · 1!)  =  12600
%   n_1! · n_2! · ··· · n_k!
%
% Responde a: ¿de cuántas formas distintas se puede ordenar x?
% ===============================================================
r_1 = factorial(n) / prod(factorial(n_4));
% Resultado: r_1 = 12600