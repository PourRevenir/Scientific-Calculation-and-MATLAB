function y = DW23_pi2

y = 4;
i = 1;
while abs(y-pi) >= 10e-6
    y = y + (-1)^i*4/(2*i+1);
    i = i+1;
end

end