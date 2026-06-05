function C = makespan(i1, j1, p, pr)

if i1<1
    C = 0;
elseif j1<1
    C = 0;
else
    C = max([makespan(i1-1, j1, p, pr), makespan(i1, j1-1, p, pr)])+...
        p(pr(i1), j1);
end