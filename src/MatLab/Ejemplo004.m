% ================================================================
% PROBLEMA 9 — SECUENCIACIÓN FLOW-SHOP: EJEMPLO CON DATOS FIJOS
% ================================================================
% n trabajos deben procesarse en m máquinas en serie (flow-shop).
% Cada trabajo i recorre las máquinas en orden 1→2→…→m.
% El tiempo de proceso del trabajo i en la máquina j es p(i,j).
%
% Objetivo: encontrar la permutación π* de los n trabajos que
% minimiza el makespan C_max = tiempo total de toda la producción.
%
% Recurrencia de programación dinámica (función makespan):
%   C(0,j) = 0  ∀j     →  sin trabajos previos, tiempo = 0
%   C(i,0) = 0  ∀i     →  antes de la 1ª máquina, tiempo = 0
%   C(i,j) = max[ C(i-1,j), C(i,j-1) ] + p(π(i), j)
% ================================================================

clc;        % Limpiar la ventana de comandos
close all;  % Cerrar todas las figuras abiertas
clear;      % Eliminar todas las variables del espacio de trabajo

% ----------------------------------------------------------------
% DATOS DEL PROBLEMA — MATRIZ DE TIEMPOS DE PROCESO
% ----------------------------------------------------------------
% p(i,j) = tiempo del trabajo i en la máquina j
% Filas  = trabajos  {J1, J2, J3, J4, J5}   → n = 5
% Columnas = máquinas {M1, M2, M3, M4}       → m = 4
%
%        M1  M2  M3  M4
%  J1  [  3   5   2   4 ]
%  J2  [  6   1   7   3 ]
%  J3  [  4   8   1   5 ]
%  J4  [  2   3   6   2 ]
%  J5  [  5   4   3   7 ]
% ----------------------------------------------------------------
p = [3 5 2 4;
     6 1 7 3;
     4 8 1 5;
     2 3 6 2;
     5 4 3 7];

[n, m] = size(p);   % n = 5 trabajos,  m = 4 máquinas

% ----------------------------------------------------------------
% EVALUACIÓN DE UNA SECUENCIA DE REFERENCIA
% ----------------------------------------------------------------
% pr define el orden en que se procesan los trabajos:
%   posición 1 → trabajo 3 (J3)
%   posición 2 → trabajo 1 (J1)
%   posición 3 → trabajo 5 (J5)
%   posición 4 → trabajo 4 (J4)
%   posición 5 → trabajo 2 (J2)
% ----------------------------------------------------------------
pr = [3, 1, 5, 4, 2];                  % Secuencia de referencia (π_ref)
C1 = makespan(n, m, p, pr);            % C_max para la secuencia pr
fprintf('C_max(π_ref) = %d\n', C1);

% ----------------------------------------------------------------
% GENERACIÓN DEL ESPACIO COMPLETO DE PERMUTACIONES
% ----------------------------------------------------------------
% perms(1:n) genera todas las n! permutaciones posibles de {1,…,n}
% El resultado es una matriz de tamaño (n! × n):
%   cada fila es una permutación distinta (una secuencia candidata)
%
% nf1 = n!  calculado con factorial()   → valor escalar exacto
% nf2 = n!  obtenido del nº de filas    → verificación cruzada
%            nf1 == nf2 siempre que n sea pequeño (n ≤ 12 aprox.)
% ----------------------------------------------------------------
prs  = perms(1:n);          % Matriz (120 × 5): las 5! = 120 permutaciones
nf1  = factorial(n);        % nf1 = 120  (n! por fórmula)
nf2  = size(prs, 1);        % nf2 = 120  (filas de la matriz de permutaciones)

% ================================================================
% MÉTODO 1 — BÚSQUEDA EXHAUSTIVA CON BUCLE for
% ================================================================
% Se evalúa el makespan de cada una de las nf1 permutaciones
% usando un bucle explícito.
%
% Complejidad: O(n! · n · m)
%   • n! iteraciones del bucle
%   • Cada llamada a makespan() recorre O(n·m) estados recursivos
%
% Ventaja   : código transparente y fácil de depurar
% Desventaja: bucle interpretado por MATLAB → lento para n grande
% ================================================================
C2 = zeros(1, nf1);         % Preasignar vector de makespans (evita reasignación)

for i1 = 1:nf1
    % prs(i1,:) es la i1-ésima permutación (fila de la matriz prs)
    C2(i1) = makespan(n, m, p, prs(i1, :));
end

% Extraer el makespan mínimo y el índice de la permutación óptima
[mnC2, idC2] = min(C2);     % mnC2 = C*_max,  idC2 = fila óptima en prs

prs(idC2, :)                % Mostrar la secuencia óptima π* (método for)
mnC2                        % Mostrar el makespan óptimo C*_max (método for)

% ================================================================
% MÉTODO 2 — BÚSQUEDA EXHAUSTIVA CON arrayfun (vectorizado)
% ================================================================
% arrayfun aplica la función anónima a cada elemento de 1:nf1
% sin bucle explícito en MATLAB; internamente equivalente al for
% pero expresado de forma más compacta.
%
% La función anónima @(idp) recibe el índice idp de la permutación
% y calcula makespan para la fila prs(idp,:) correspondiente.
%
% Complejidad: O(n! · n · m)  — idéntica al método 1
% Ventaja   : código más conciso; ligeramente más idiomático
% Desventaja: misma velocidad que el bucle for en MATLAB;
%             menos intuitivo para principiantes
% ================================================================
C3 = arrayfun(@(idp) makespan(n, m, p, prs(idp, :)), 1:nf1);

% Extraer el makespan mínimo y la permutación óptima
[mnC3, idC3] = min(C3);     % mnC3 = C*_max,  idC3 = fila óptima en prs

prs(idC3, :)                % Mostrar la secuencia óptima π* (método arrayfun)
mnC3                        % Mostrar el makespan óptimo C*_max (método arrayfun)

% Ambos métodos deben producir el mismo resultado:
%   prs(idC2,:) == prs(idC3,:)  y  mnC2 == mnC3