clc;
close all;
clear;

p = [3 5 2 4; 6 1 7 3; 4 8 1 5; 2 3 6 2; 5 4 3 7];
[n, m] = size(p);

pr = [3, 1, 5, 4, 2];

C1 = makespan(n, m, p, pr);

prs = perms(1:n);
nf1 = factorial(n);
nf2 = size(prs,1);

C2 = zeros(1, nf1);
for i1=1:nf1
    C2(i1) = makespan(n, m, p, prs(i1, :));
end
[mnC2, idC2] = min(C2);
prs(idC2,:)
mnC2

C3 = arrayfun(@(idp) makespan(n, m, p, prs(idp, :)), 1:nf1);
[mnC3, idC3] = min(C3);
prs(idC3,:)
mnC3
