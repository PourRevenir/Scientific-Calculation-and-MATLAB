function y = DW23_pi1

y = 4;
for i = 1:20000
    y = y + (-1)^i*4/(2*i+1);
    if abs(y-pi) < 10e-6
        break;
    end
end

end