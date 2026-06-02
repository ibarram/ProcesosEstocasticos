clc;
clear all;

P1 = cell(1,3);
P1{1} = 1:6;
P1{2} = 1:2;
P1{3} = 1:3;

ne = length(P1);
ni = zeros(1, ne);
for i1=1:ne
    ni(i1) = length(P1{i1});
end
n = prod(ni);