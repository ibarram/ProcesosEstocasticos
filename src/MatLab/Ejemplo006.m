clc;
close all;
% =========================================================
% PARÁMETROS DEL CANAL BINARIO
% =========================================================
nb = 3;          % Número de bits por palabra transmitida
n_omg = 2^nb;   % Cardinalidad del espacio muestral: |Ω| = 2^3 = 8

% =========================================================
% CONSTRUCCIÓN DEL ESPACIO MUESTRAL Ω
% =========================================================
% dec2bin genera los enteros 0..7 en binario (como caracteres ASCII).
% Al restar '0' se convierte cada carácter a su valor numérico {0,1},
% obteniendo una matriz de 8x3 donde cada fila es una palabra de 3 bits.
% Ω = {000, 001, 010, 011, 100, 101, 110, 111}
omg = dec2bin(0:(n_omg-1))-'0';

% =========================================================
% EVENTO A = "el primer bit recibido es 1"
% A = {100, 101, 110, 111}
% =========================================================
% Vector lógico indicador: f_A(i)=true si la palabra i pertenece a A
f_A = omg(:,1)==1;
n_A = sum(f_A);          % Cardinalidad: |A| = 4
A   = omg(f_A,:);        % Palabras que pertenecen a A

% Complemento A' = Ω \ A = "el primer bit recibido es 0"
% A' = {000, 001, 010, 011}
% Requerido por De Morgan: (A ∪ B)' = A' ∩ B' y (A ∩ B)' = A' ∪ B'
f_Ac  = ~f_A;            % Negación lógica del indicador de A
Ac    = omg(f_Ac,:);     % Palabras que pertenecen a A'

% Verificación de axioma: A ∪ A' = Ω (cerradura bajo complemento)
AuAc  = omg(f_A|f_Ac,:);% Debe recuperar las 8 filas de Ω

% =========================================================
% EVENTO B = "exactamente un bit es 1"
% B = {001, 010, 100}
% =========================================================
% sum(omg,2) suma los bits de cada fila (peso de Hamming).
% La condición ==1 selecciona palabras con peso de Hamming igual a 1.
f_B = sum(omg,2)==1;
n_B = sum(f_B);          % Cardinalidad: |B| = 3
B   = omg(f_B,:);        % Palabras que pertenecen a B

% Complemento B' = Ω \ B = "el número de unos ≠ 1"
% B' = {000, 011, 101, 110, 111}
% Requerido por De Morgan: (A ∪ B)' = A' ∩ B' y (B ∪ C)' = B' ∩ C'
f_Bc  = ~f_B;
Bc    = omg(f_Bc,:);

% Verificación de axioma: B ∪ B' = Ω (cerradura bajo complemento)
BuBc  = omg(f_B|f_Bc,:);

% =========================================================
% EVENTO C = "el número de unos es par (incluyendo cero)"
% C = {000, 011, 101, 110}
% =========================================================
% mod(sum(omg,2),2)==0 es true cuando el peso de Hamming es par.
% La negación (~) del módulo equivale a paridad par (0 mod 2 = 0 → ~0 = true).
f_C = ~mod(sum(omg,2),2);
n_C = sum(f_C);          % Cardinalidad: |C| = 4
C   = omg(f_C,:);        % Palabras que pertenecen a C

% Complemento C' = Ω \ C = "el número de unos es impar"
% C' = {001, 010, 100, 111}
% Requerido por De Morgan: (A ∪ C)' = A' ∩ C' y (B ∪ C)' = B' ∩ C'
f_Cc  = ~f_C;
Cc    = omg(f_Cc,:);

% Verificación de axioma: C ∪ C' = Ω (cerradura bajo complemento)
CuCc  = omg(f_C|f_Cc,:);

% =========================================================
% UNIONES ENTRE EVENTOS — cerradura bajo uniones finitas
% Estos conjuntos son el lado izquierdo de las leyes de De Morgan:
%   Primera ley:  (X ∪ Y)' = X' ∩ Y'
%   Segunda ley:  (X ∩ Y)' = X' ∪ Y'
% =========================================================

% A ∪ B = "el primer bit es 1, O exactamente un bit es 1"
% A ∪ B = {001, 010, 100, 101, 110, 111}
% Usado en De Morgan: (A ∪ B)' debe coincidir con A' ∩ B'
f_AuB = f_A|f_B;
AuB   = omg(f_AuB,:);
n_AuB = sum(f_AuB);      % Cardinalidad: |A ∪ B| = 6

% A ∪ C = "el primer bit es 1, O el número de unos es par"
% A ∪ C = {000, 011, 100, 101, 110, 111}
% Usado en De Morgan: (A ∪ C)' debe coincidir con A' ∩ C'
f_AuC = f_A|f_C;
AuC   = omg(f_AuC,:);
n_AuC = sum(f_AuC);      % Cardinalidad: |A ∪ C| = 6

% B ∪ C = "exactamente un bit es 1, O el número de unos es par"
% B ∪ C = {000, 001, 010, 011, 100, 101, 110}
% Usado en De Morgan: (B ∪ C)' debe coincidir con B' ∩ C'
f_BuC = f_B|f_C;
BuC   = omg(f_BuC,:);
n_BuC = sum(f_BuC);      % Cardinalidad: |B ∪ C| = 7

% =========================================================
% VERIFICACIÓN DE LA PRIMERA LEY DE DE MORGAN: (X ∪ Y)' = X' ∩ Y'
% Para cada par de eventos se comparan elemento a elemento los
% vectores lógicos de ambos lados de la igualdad.
% prod(f_M1==f_M2) devuelve 1 (verdadero) si y solo si los dos
% vectores son idénticos en todas las posiciones, es decir,
% si ambos lados clasifican igual cada palabra de Ω.
% =========================================================

% Par A, B — Primera ley de De Morgan: (A ∪ B)' = A' ∩ B'
% Lado izquierdo: complemento de la unión A ∪ B
% (A ∪ B)' = {000, 011} → palabras con primer bit 0 y peso ≠ 1
f_M1 = ~(f_A|f_B);
% Lado derecho: intersección de los complementos A' ∩ B'
% A' ∩ B' = {000, 011} → mismo resultado esperado
f_M2 = f_Ac&f_Bc;
% M_AB = 1 confirma que (A ∪ B)' = A' ∩ B' se cumple en todo Ω
M_AB = prod(f_M1==f_M2);

% Par A, C — Primera ley de De Morgan: (A ∪ C)' = A' ∩ C'
% Lado izquierdo: complemento de la unión A ∪ C
% (A ∪ C)' = {001, 010} → palabras con primer bit 0 y peso impar
f_M1 = ~(f_A|f_C);
% Lado derecho: intersección de los complementos A' ∩ C'
% A' ∩ C' = {001, 010} → mismo resultado esperado
f_M2 = f_Ac&f_Cc;
% M_AC = 1 confirma que (A ∪ C)' = A' ∩ C' se cumple en todo Ω
M_AC = prod(f_M1==f_M2);

% Par B, C — Primera ley de De Morgan: (B ∪ C)' = B' ∩ C'
% Lado izquierdo: complemento de la unión B ∪ C
% (B ∪ C)' = {111} → única palabra con peso impar mayor que 1
f_M1 = ~(f_B|f_C);
% Lado derecho: intersección de los complementos B' ∩ C'
% B' ∩ C' = {111} → mismo resultado esperado
f_M2 = f_Bc&f_Cc;
% M_BC = 1 confirma que (B ∪ C)' = B' ∩ C' se cumple en todo Ω
M_BC = prod(f_M1==f_M2);