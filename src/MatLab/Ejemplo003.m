clc;
clear all;

x = [1, 1, 1, 2, 2, 2, 2, 3, 3, 4];
n = length(x);
g = unique(x);
k = length(g);

n_1 = zeros(1, k);
for i1=1:k
    n_1(i1) = 0;
    for i2=1:n
        if(x(i2)==g(i1))
            n_1(i1) = n_1(i1) + 1;
        end
    end
end

n_2 = zeros(1, k);
for i1=1:k
    n_2(i1) = length(find(x==g(i1)));
end

n_3 = zeros(1, k);
for i1=1:k
    n_3(i1) = sum(x==g(i1));
end

% n_4 = sum((g'*ones(1,n))==(ones(k,1)*x),2);
n_4 = sum((x'*ones(1,k))==(ones(n,1)*g));

r_1 = factorial(n)/prod(factorial(n_4));

