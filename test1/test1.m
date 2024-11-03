clear;

%% problem 1
a = -3.0:0.2:3.0;
x = sinh(0.3*a).*sin(a+0.3)+log(0.15+0.5*a);
x

%% problem 2
A = [12     34      -4;
     34     7       87;
     3      65      7];

B = [1      3       -1;
     2      0       3;
     3      -2      7];

A+6*B
A-B+eye(3,3)
A*B
A.*B
A^3
A.^3
A/B
A\B
[A,B]
[A([1,3],:);B^2]

%% problem 3
x = 100:999;
length(find(rem(x,21))

%% problem 4
string ='anCDHUe123';
k = find(string>='A' & string<='Z');
string(k) = [];
string
