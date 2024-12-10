function y = DW23_1(n)

y = 1;
for i = 1:n
    b = 4*i.^2;
    y = y*b/(b-1);
end

end