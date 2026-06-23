% ================================================================
% FUNCIÓN MAKESPAN — RECURRENCIA DE PROGRAMACIÓN DINÁMICA
% ================================================================
% Calcula C_max(π) para la secuencia π usando la recurrencia:
%
%   C(0,j) = 0  ∀j       (sin trabajos previos, tiempo cero)
%   C(i,0) = 0  ∀i       (antes de la primera máquina, tiempo cero)
%   C(i,j) = max[C(i-1,j), C(i,j-1)] + p(π(i), j)
%
% Argumentos:
%   i1  — número de trabajos a considerar (1..n)
%   j1  — número de máquinas a considerar (1..m)
%   p   — matriz de tiempos de proceso (n × m)
%   pr  — permutación (secuencia) de trabajos
%
% Retorna:
%   C   — makespan C(i1,j1), tiempo de fin del trabajo i1 en máquina j1
%
% Complejidad por llamada: O(n·m) estados en el árbol de recursión;
% cada estado se evalúa una sola vez (sin memoización explícita,
% dado que n·m es pequeño en los casos de uso previstos).
% Para n·m grande, sustituir por la versión iterativa equivalente.
% ================================================================

function C = makespan(i1, j1, p, pr)
    if i1 < 1 || j1 < 1
        % Caso base: sin trabajos o sin máquinas → tiempo acumulado = 0
        C = 0;
    else
        % Caso recursivo: el trabajo π(i1) en la máquina j1 no puede
        % comenzar hasta que:
        %   (a) el trabajo previo π(i1-1) haya salido de la máquina j1
        %   (b) el mismo trabajo π(i1) haya terminado en la máquina j1-1
        % El máximo de ambos da el instante de inicio; se suma p(π(i1),j1)
        C = max([makespan(i1-1, j1, p, pr), ...
                 makespan(i1, j1-1, p, pr)]) + p(pr(i1), j1);
    end
end