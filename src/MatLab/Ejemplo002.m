clc;    % Limpiar la ventana de comandos
clear;  % Eliminar todas las variables del espacio de trabajo

% ---------------------------------------------------------------
% PRINCIPIO FUNDAMENTAL DE CONTEO
% Si un experimento compuesto consta de k eventos independientes,
% con n1, n2, ..., nk resultados posibles respectivamente,
% entonces el número total de resultados es n1 * n2 * ... * nk
% ---------------------------------------------------------------

% --- Definición de los espacios muestrales de cada evento ---
% Se usa un arreglo de celdas para almacenar eventos con distinto
% número de resultados posibles
P1 = cell(1, 3);       % Arreglo de celdas para 3 eventos independientes

% Evento 1: lanzamiento de un dado de seis caras
%           resultados posibles: {1, 2, 3, 4, 5, 6}
P1{1} = 1:6;

% Evento 2: lanzamiento de una moneda
%           resultados posibles: {1=sol, 2=águila}
P1{2} = 1:2;

% Evento 3: extracción de una canica de una bolsa con tres colores
%           resultados posibles: {1=roja, 2=azul, 3=negra}
P1{3} = 1:3;

% --- Número de eventos en el experimento compuesto ---
ne = length(P1);        % ne = 3 (número de eventos)

% --- Número de resultados posibles por evento ---
ni = zeros(1, ne);      % Inicializar vector de cardinalidades
for i1 = 1:ne
    ni(i1) = length(P1{i1});   % ni = [6, 2, 3]
end

% --- Aplicación del principio fundamental de conteo ---
% Número total de resultados del experimento compuesto:
% n = 6 * 2 * 3 = 36 resultados igualmente posibles
n = prod(ni);