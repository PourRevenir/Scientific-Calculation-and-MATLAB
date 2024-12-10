function [y] = DW23_3(n)

y = 4*(1:n).^2./(4*(1:n).^2-1);
y = prod(y);

end