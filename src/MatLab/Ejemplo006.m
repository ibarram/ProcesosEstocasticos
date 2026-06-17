clc;
close all;

nb = 3;
n_omg = 2^nb;
omg = dec2bin(0:(n_omg-1))-'0';

f_A = omg(:,1)==1;
n_A = sum(f_A);
A = omg(f_A,:);

f_B = sum(omg,2)==1;
n_B = sum(f_B);
B = omg(f_B,:);

f_C = ~mod(sum(omg,2),2);
n_C = sum(f_C);
C = omg(f_C,:);