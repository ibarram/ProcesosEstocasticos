% ================================================================
% PROBLEMA 9 — SECUENCIACIÓN FLOW-SHOP: LECTURA GENERALIZADA
% ================================================================
% Versión parametrizada que lee los tiempos de proceso p(i,j)
% desde un archivo CSV seleccionado por el usuario mediante un
% diálogo de exploración de archivos.
%
% Flujo del programa:
%   1. Detectar el sistema operativo para construir rutas portables
%   2. Navegar automáticamente a la carpeta de datos del proyecto
%   3. Abrir un diálogo para que el usuario seleccione el CSV
%   4. Leer la matriz de tiempos ignorando líneas de comentario
%   5. Enumerar todas las n! permutaciones (búsqueda exhaustiva)
%   6. Evaluar el makespan de cada permutación con arrayfun
%   7. Reportar la secuencia óptima π* y el makespan mínimo C*
%
% Recurrencia del makespan (ver función local al final):
%   C(0,j) = 0  ∀j,   C(i,0) = 0  ∀i
%   C(i,j) = max[ C(i-1,j), C(i,j-1) ] + p(π(i), j)
% ================================================================

clc;        % Limpiar la ventana de comandos
close all;  % Cerrar todas las figuras abiertas
clear;      % Eliminar todas las variables del espacio de trabajo

% ----------------------------------------------------------------
% SECCIÓN 1 — DETECCIÓN DEL SISTEMA OPERATIVO
% ----------------------------------------------------------------
% El separador de carpetas difiere entre sistemas operativos:
%   Windows  →  '\' (barra invertida)
%   Linux / macOS  →  '/' (barra directa)
%
% ispc() devuelve true si MATLAB se ejecuta en Windows.
% Usar el separador correcto garantiza que las rutas construidas
% con concatenación de cadenas funcionen en cualquier plataforma.
% ----------------------------------------------------------------
if ispc
    d = '\';        % Separador de directorio en Windows
else
    d = '/';        % Separador de directorio en Linux / macOS
end

% ----------------------------------------------------------------
% SECCIÓN 2 — CONSTRUCCIÓN DE LA RUTA A LA CARPETA DE DATOS
% ----------------------------------------------------------------
% Estrategia de navegación relativa al directorio de trabajo:
%
%   pwd  →  directorio de trabajo actual (donde está este script)
%
%   Se asume la siguiente estructura de proyecto:
%     <raíz>/
%       código/   ← directorio de trabajo actual (pwd)
%       data/
%         AC_P09/ ← carpeta donde están los archivos CSV
%
%   idd = find(path_txt == d)
%     Encuentra las posiciones de todos los separadores '/' o '\'
%     en la cadena de la ruta actual.
%
%   idd(end-1)
%     Posición del penúltimo separador, es decir, el límite de la
%     carpeta padre de la carpeta actual (sube un nivel en el árbol).
%
%   path_txt(1:idd(end-1))
%     Prefijo de la ruta hasta la carpeta raíz del proyecto.
%
%   Se concatena con 'data', d, 'AC_P09', d para apuntar a:
%     <raíz>/data/AC_P09/
% ----------------------------------------------------------------
path_txt = pwd;                         % Ruta del directorio actual
idd      = find(path_txt == d);         % Índices de todos los separadores

% Subir un nivel y apuntar a la subcarpeta de datos del problema
path_txt = [path_txt(1:idd(end-1)), 'data', d, 'AC_P09', d];

% ----------------------------------------------------------------
% SECCIÓN 3 — DIÁLOGO DE SELECCIÓN DEL ARCHIVO CSV
% ----------------------------------------------------------------
% uigetfile abre un explorador de archivos gráfico y devuelve:
%   file_bd  →  nombre del archivo seleccionado (solo nombre + ext)
%   (la ruta completa se obtiene concatenando path_txt + file_bd)
%
% Argumentos de uigetfile:
%   '*.csv'   →  filtro: mostrar solo archivos CSV
%   'Seleccione su archivo'  →  título de la ventana de diálogo
%   path_txt  →  carpeta inicial que abre el explorador
%
% Si el usuario cancela el diálogo, file_bd devuelve 0 (numérico).
% En ese caso readmatrix fallará; se puede agregar validación con:
%   if isequal(file_bd, 0), error('No se seleccionó archivo'); end
% ----------------------------------------------------------------
file_bd = uigetfile('*.csv', 'Seleccione su archivo', path_txt);

% ----------------------------------------------------------------
% SECCIÓN 4 — LECTURA DE LA MATRIZ DE TIEMPOS DE PROCESO
% ----------------------------------------------------------------
% readmatrix lee el CSV e ignora las líneas que comienzan con '#'
% gracias al parámetro 'CommentStyle','#', permitiendo que el
% archivo incluya encabezados o metadatos sin afectar la lectura.
%
% Resultado: p(i,j) = tiempo del trabajo i en la máquina j
%   Filas    → trabajos  {J1, …, Jn}
%   Columnas → máquinas  {M1, …, Mm}
% ----------------------------------------------------------------
p = readmatrix([path_txt, file_bd], 'CommentStyle', '#');

[n, m] = size(p);       % n = número de trabajos, m = número de máquinas

fprintf('Archivo cargado : %s\n', file_bd);
fprintf('Trabajos n = %d,  Máquinas m = %d\n\n', n, m);

% ----------------------------------------------------------------
% SECCIÓN 5 — GENERACIÓN DE TODAS LAS PERMUTACIONES
% ----------------------------------------------------------------
% perms(1:n) genera la matriz completa de n! permutaciones de {1,…,n}
% Cada fila representa una secuencia candidata π de los n trabajos.
%
% El bloque try-catch protege el programa cuando n es grande:
%   • Para n ≤ 12 aprox., perms() es viable en memoria
%   • Para n > 12, la matriz n!×n excede la RAM disponible y
%     MATLAB lanza un error; el catch lo captura silenciosamente
%     (en ese caso se debería usar una metaheurística en su lugar)
%
% nf1 = n!  calculado con factorial()  →  número exacto de permutaciones
% nf2 = n!  obtenido de size(prs,1)   →  verificación cruzada
%            (nf1 == nf2 si perms() tuvo éxito)
% ----------------------------------------------------------------
try
    prs = perms(1:n);       % Matriz (n! × n) de todas las permutaciones
catch
    % Si n es demasiado grande, prs no se genera;
    % aquí se podría inicializar un método alternativo (SA, GA, etc.)
end

nf1 = factorial(n);         % Cardinalidad del espacio de búsqueda: |Sₙ| = n!
nf2 = size(prs, 1);         % Número de filas de la matriz de permutaciones

fprintf('Espacio de búsqueda: %d! = %d secuencias\n\n', n, nf1);

% ================================================================
% SECCIÓN 6 — EVALUACIÓN EXHAUSTIVA DEL MAKESPAN (arrayfun)
% ================================================================
% arrayfun aplica la función anónima @(idp) a cada valor de 1:nf1,
% evaluando el makespan de la permutación prs(idp,:) sin bucle
% explícito en MATLAB.
%
% La función anónima captura n, m, p y prs del espacio de trabajo
% (clausura) y pasa la fila idp-ésima de prs como secuencia π.
%
% Resultado: C(idp) = C_max para la permutación prs(idp,:)
%
% Complejidad: O(n! · n · m)
%   • nf1 = n! evaluaciones de makespan
%   • Cada makespan() tiene coste O(n·m) en el árbol de recursión
% ================================================================
C = arrayfun(@(idp) makespan(n, m, p, prs(idp, :)), 1:nf1);

% ----------------------------------------------------------------
% SECCIÓN 7 — EXTRACCIÓN DE LA SOLUCIÓN ÓPTIMA
% ----------------------------------------------------------------
% min(C) devuelve:
%   mnC  →  makespan mínimo C*_max  (valor objetivo óptimo)
%   idC  →  índice de la permutación óptima en la matriz prs
%
% prs(idC,:) es la secuencia π* que minimiza el makespan.
% ----------------------------------------------------------------
[mnC, idC] = min(C);        % mnC = C*_max,  idC = fila óptima en prs

fprintf('Secuencia óptima π* = ');
disp(prs(idC, :));          % Mostrar la permutación óptima de trabajos

fprintf('Makespan óptimo C*_max = %d\n', mnC);