function y = DW23_2(n)

y = 1;
i = 1;
while i<=n
    b = 4*i.^2;
    y = y*b/(b-1);
    i = i + 1;
end

end