function y = DW23_sum1(x,n)

y = 1;
b = 1;
for i = 1:n
    m = 2*i;
    b = m*b;
    y = y + (-1)^i*x^m./b;
end

end