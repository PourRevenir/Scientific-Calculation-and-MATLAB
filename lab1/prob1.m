clearvars

format long

i = 1;
j = 1;
e = 1;
eps = 1;

while eps >= 1e-5
    e = e + 1/j;
    eps = exp(1) - e;
    i = i + 1;
    j = j*i;
end