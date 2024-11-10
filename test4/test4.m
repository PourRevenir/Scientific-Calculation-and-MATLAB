clearvars;

%% problem 1
score2level(100)
score2level(31)
score2level(56)
score2level(77)
score2level(89)
score2level(150)

%% problem 2
for i = [1e2,1e3,1e4]
    x = 1:i;
    sqrt(sum(6./(x.^2)))
end
