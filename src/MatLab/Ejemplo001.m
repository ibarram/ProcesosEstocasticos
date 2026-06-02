clc;
close all;

N = 100;
nd = 5;

m = 1.8;
s = 0.1;
d = 4*s/nd;

x = m + s .* randn(N,1);
P = zeros(1, nd);
for i1=1:nd
    P(i1) = sum(ceil(abs(x-m+2*s)/d)==i1);
end
P(nd) = sum(ceil(abs(x-m+2*s)/d)>(nd-1));