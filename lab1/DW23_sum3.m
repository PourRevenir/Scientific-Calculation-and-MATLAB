function y = DW23_sum3(x,n)

y = (-1).^(1:n).*x.^(2*(1:n))./factorial(2*(1:n));
y = sum(y)+1;

end