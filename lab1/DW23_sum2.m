function y = DW23_sum2(x,n)

y = 1;
b = 1;
while i <= n
    m = 2*i;
    b = m*b;
    y = y + (-1)^i*x^m./b;
    i = i+1;
end

end