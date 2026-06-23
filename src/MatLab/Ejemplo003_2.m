% ================================================================
% ANÁLISIS DE HISTOGRAMA — COMPARATIVA DE CUATRO MÉTODOS
% ================================================================
% Objetivo: calcular la frecuencia absoluta de cada clase en un
% vector de observaciones y comparar el rendimiento de cuatro
% estrategias de conteo distintas.
%
% Complejidad teórica de todos los métodos: O(n·k)
%   n = número de observaciones
%   k = número de clases únicas
%
% Diferencia práctica: los métodos 1-3 usan bucles interpretados
% en MATLAB; el método 4 usa operaciones matriciales vectorizadas
% ejecutadas en código C compilado → significativamente más rápido
% para n y k grandes.
% ================================================================

clc;
clear all;

% --- Datos de entrada ---
x = [1, 1, 1, 2, 2, 2, 2, 3, 3, 4];   % Vector de observaciones
                                         % (puede contener enteros,
                                         %  etiquetas o categorías)

n = length(x);      % Total de observaciones: n = 10
g = unique(x);      % Clases distintas en orden ascendente: [1,2,3,4]
k = length(g);      % Número de clases: k = 4

fprintf('=== Datos ===\n');
fprintf('  n = %d observaciones\n', n);
fprintf('  k = %d clases únicas\n\n', k);

% ================================================================
% MÉTODO 1 — Doble bucle anidado con comparación escalar
% ----------------------------------------------------------------
% Complejidad tiempo : O(n·k)  — n·k comparaciones escalares
% Complejidad espacio: O(1)    — solo contadores enteros
% Ventajas  : máxima transparencia; fácil de depurar y explicar
% Desventajas: el bucle doble es interpretado por MATLAB → lento
%              para n y k grandes (peor caso práctico)
% ================================================================
t1_ini = tic;

n_1 = zeros(1, k);          % Inicializar frecuencias en cero
for i1 = 1:k
    n_1(i1) = 0;            % Reiniciar contador de la clase i1
    for i2 = 1:n
        if (x(i2) == g(i1))             % Comparación escalar uno a uno
            n_1(i1) = n_1(i1) + 1;      % Incrementar frecuencia de clase i1
        end
    end
end

t1 = toc(t1_ini);           % Tiempo de ejecución del método 1

% ================================================================
% MÉTODO 2 — Bucle simple con find()
% ----------------------------------------------------------------
% Complejidad tiempo : O(n·k)  — k llamadas a find(), cada una O(n)
% Complejidad espacio: O(n)    — find() aloca un vector de índices
%                                de hasta longitud n por llamada
% Ventajas  : bucle simple; devuelve índices (útiles en otros contextos)
% Desventajas: aloca memoria adicional innecesaria si solo se
%              necesita el conteo; ligeramente más lento que M3
% ================================================================
t2_ini = tic;

n_2 = zeros(1, k);
for i1 = 1:k
    % find() devuelve vector de posiciones donde x == g(i1);
    % length() de ese vector equivale al conteo de coincidencias
    n_2(i1) = length(find(x == g(i1)));
end

t2 = toc(t2_ini);

% ================================================================
% MÉTODO 3 — Bucle simple con sum() sobre vector lógico
% ----------------------------------------------------------------
% Complejidad tiempo : O(n·k)  — k llamadas a sum(), cada una O(n)
% Complejidad espacio: O(n)    — vector lógico temporal de longitud n
%                                (liberado inmediatamente tras sum)
% Ventajas  : código compacto y legible; sin overhead de índices;
%             la mejor relación legibilidad/rendimiento con bucle
% Desventajas: aún requiere k iteraciones del bucle externo
% ================================================================
t3_ini = tic;

n_3 = zeros(1, k);
for i1 = 1:k
    % (x == g(i1)) produce vector lógico de longitud n;
    % sum() cuenta los TRUE (equivale a frecuencia absoluta)
    n_3(i1) = sum(x == g(i1));
end

t3 = toc(t3_ini);

% ================================================================
% MÉTODO 4 — Broadcasting matricial (vectorización completa)
% ----------------------------------------------------------------
% Complejidad tiempo : O(n·k)  — una sola operación vectorizada
%                                ejecutada en código C compilado
% Complejidad espacio: O(n·k)  — matriz booleana de n×k elementos
%                                (PRECAUCIÓN: con n·k > ~5·10^6
%                                 puede causar presión de memoria)
%
%   x'         → vector columna (n×1)
%   ones(n,1)*g → réplica de g en n filas → matriz (n×k)
%   x'*ones(1,k)→ réplica de x' en k cols → matriz (n×k)
%   Igualdad elemento a elemento → matriz booleana (n×k)
%   sum(...,1)  → suma por columnas → vector (1×k) de frecuencias
%
% Ventajas  : sin bucles interpretados; más rápido para n,k grandes;
%             expresión compacta y elegante
% Desventajas: uso de memoria O(n·k); menos intuitivo para principiantes;
%              no recomendado si n·k > 5·10^6 por presión de memoria
%
% Línea alternativa equivalente (opera por filas en lugar de columnas):
%   n_4 = sum((g'*ones(1,n)) == (ones(k,1)*x), 2)';
% ================================================================
t4_ini = tic;

% Construir matriz de comparación y sumar por columnas
n_4 = sum((x' * ones(1,k)) == (ones(n,1) * g));

t4 = toc(t4_ini);

% ================================================================
% VERIFICACIÓN DE CONSISTENCIA
% Todos los métodos deben producir el mismo resultado
% ================================================================
assert(isequal(n_1, n_2), 'ERROR: M1 y M2 difieren');
assert(isequal(n_1, n_3), 'ERROR: M1 y M3 difieren');
assert(isequal(n_1, n_4), 'ERROR: M1 y M4 difieren');

fprintf('=== Frecuencias absolutas (todos los métodos coinciden) ===\n');
fprintf('  Clase | Frec\n');
fprintf('  ------|-----\n');
for i1 = 1:k
    fprintf('  %5d | %4d\n', g(i1), n_1(i1));
end
fprintf('\n');

% ================================================================
% COEFICIENTE MULTINOMIAL
% ----------------------------------------------------------------
% Número de permutaciones distinguibles del vector x:
%
%          n!
%   r = ─────────────  =  10! / (3!·4!·2!·1!)  =  12 600
%       n_1!·n_2!·…·n_k!
%
% Responde: ¿de cuántas formas distintas se puede reordenar x?
% Se usa n_4 por ser el resultado del método más eficiente.
% ================================================================
r_1 = factorial(n) / prod(factorial(n_4));
fprintf('=== Coeficiente multinomial ===\n');
fprintf('  Permutaciones distinguibles de x: %d\n\n', r_1);

% ================================================================
% INFORME DE TIEMPOS Y ANÁLISIS COMPARATIVO
% ================================================================
tiempos = [t1, t2, t3, t4] * 1e6;      % Convertir a microsegundos
t_max   = max(tiempos);

fprintf('=== Análisis de rendimiento ===\n');
fprintf('  %-12s | %-14s | %-10s | %-10s | %s\n', ...
        'Método', 'Tiempo (µs)', 'vs M1 (%)', 'Espacio', 'Estrategia');
fprintf('  %s\n', repmat('-', 1, 72));

etiquetas  = {'M1 — doble for', 'M2 — find()', ...
              'M3 — sum lógico', 'M4 — matricial'};
espacio    = {'O(1)', 'O(n)', 'O(n)', 'O(n·k)'};
estrategia = {'Bucle doble escalar', 'Búsqueda de índices', ...
              'Vector lógico', 'Broadcasting'};

for i1 = 1:4
    pct = tiempos(i1) / tiempos(1) * 100;
    fprintf('  %-15s | %14.4f | %9.1f%% | %-10s | %s\n', ...
            etiquetas{i1}, tiempos(i1), pct, ...
            espacio{i1}, estrategia{i1});
end

fprintf('\n');
fprintf('  Complejidad teórica de todos los métodos: O(n·k)\n');
fprintf('  n = %d,  k = %d,  n·k = %d\n', n, k, n*k);
fprintf('\n');

% --- Recomendación automática según tamaño del problema ---
fprintf('=== Recomendación según tamaño del problema ===\n');
umbral_mem = 5e6;       % n·k máximo recomendado para método 4
if n * k < 1000
    fprintf('  n·k = %d  →  cualquier método es adecuado.\n', n*k);
    fprintf('             Preferir M3 por legibilidad.\n');
elseif n * k < umbral_mem
    fprintf('  n·k = %d  →  usar M4 (vectorizado, memoria aceptable).\n', n*k);
else
    fprintf('  n·k = %d  →  precaución con M4 (memoria O(n·k) elevada).\n', n*k);
    fprintf('             Usar M3 como alternativa equilibrada.\n');
end

% ================================================================
% VISUALIZACIÓN COMPARATIVA
% ================================================================
figure('Name', 'Análisis de histograma — comparativa de métodos', ...
       'NumberTitle', 'off');

% --- Panel 1: Histograma resultante ---
subplot(1, 3, 1);
bar(g, n_1, 0.6, 'FaceColor', [0.22 0.45 0.70], 'EdgeColor', 'none');
xlabel('Clase'); ylabel('Frecuencia absoluta');
title('Histograma de x');
xticks(g);
grid on; box off;

% --- Panel 2: Tiempo de ejecución por método ---
subplot(1, 3, 2);
colores = [0.89 0.29 0.29;   % rojo   — M1
           0.73 0.46 0.09;   % ámbar  — M2
           0.09 0.37 0.64;   % azul   — M3
           0.06 0.43 0.34];  % verde  — M4
b = bar(tiempos, 0.6, 'FaceColor', 'flat', 'EdgeColor', 'none');
b.CData = colores;
set(gca, 'XTickLabel', {'M1','M2','M3','M4'});
ylabel('Tiempo (µs)');
title('Tiempo de ejecución');
grid on; box off;
% Anotar valor sobre cada barra
for i1 = 1:4
    text(i1, tiempos(i1) + t_max*0.02, ...
         sprintf('%.3f', tiempos(i1)), ...
         'HorizontalAlignment', 'center', 'FontSize', 8);
end

% --- Panel 3: Complejidad espacial cualitativa ---
subplot(1, 3, 3);
% Representar costo de memoria relativo (O(1)=1, O(n)=n, O(n·k)=n·k)
mem_rel = [1, n, n, n*k];
b2 = bar(mem_rel, 0.6, 'FaceColor', 'flat', 'EdgeColor', 'none');
b2.CData = colores;
set(gca, 'XTickLabel', {'M1','M2','M3','M4'}, 'YScale', 'log');
ylabel('Unidades de memoria (escala log)');
title('Complejidad espacial relativa');
grid on; box off;
yline(1,  '--k', 'O(1)',   'LabelHorizontalAlignment','left','FontSize',8);
yline(n,  '--', 'O(n)',   'LabelHorizontalAlignment','left','FontSize',8, ...
      'Color',[0.4 0.4 0.4]);
yline(n*k,'--', 'O(n·k)','LabelHorizontalAlignment','left','FontSize',8, ...
      'Color',[0.6 0.2 0.2]);

sgtitle('Histograma: comparativa de cuatro métodos de conteo', ...
        'FontWeight', 'bold');