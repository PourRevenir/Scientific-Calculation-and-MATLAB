clearvars;

%% problem 1
B = [3       0      16;
     17     -6      9;
     0      23      -4
     9      7       0
     4      13      11];
A = B(end-2:end,end-1:end)

%% problem 2
A = hilb(4);
A = A(1:3,2:4);
b = [0.95;0.67;0.52];
A\b

b(3) = 0.53;
A\b