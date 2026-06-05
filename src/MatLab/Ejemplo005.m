clc;
close all;
clear;

if ispc
    d = '\';
else
    d = '/';
end

%file_bd = 'instancia_01_3x2_minimo.csv';
path_txt = pwd;
idd = find(path_txt==d);
path_txt = [path_txt(1:idd(end-1)), 'data', d, 'AC_P09', d];

file_bd = uigetfile('*.csv', 'Seleccione su archivo', path_txt);

p = readmatrix([path_txt, file_bd], 'CommentStyle', '#');

[n, m] = size(p);

try
    prs = perms(1:n);
catch

end
nf1 = factorial(n);
nf2 = size(prs,1);

C = arrayfun(@(idp) makespan(n, m, p, prs(idp, :)), 1:nf1);
[mnC, idC] = min(C);
prs(idC,:)
mnC
