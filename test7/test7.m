clearvars;

%% problem 1
syms x

A = det([x      x^2     x^3;
         1      2*x     3*x^2;
         0      2       6*x]);

dA = diff(A);

xx = [1 2 3];
subs(dA,xx)

clearvars x xx A dA
%% problem 2
format long
[w,x] = GaussLegendreCoef(8);

% problem 2-1
f =@(t) cos(t.^2) + 4*sin(4*t.^2) +1;
a = 0;
b = 2*pi;

t = 0.5*(b-a).*x +0.5*(b+a);
I1 = 0.5*(b-a)*sum(w.*f(t));
I1

clearvars a b f t 
% problem 2-2
f =@(x) log(1+x)./(1+x.^2);
a = 0;
b = 1;
t = 0.5*(b-a).*x +0.5*(b+a);
I2 = 0.5*(b-a)*sum(w.*f(t));
I2

clearvars

%% problem 3
A = [6      5       -2      5;
     9      -1      4       -1;
     3      4       2       -2;
     3      -9      0       2];
b = [-4;
     3;
     1;
     11];

x = A\b

x = inv(A)*b

[L,U,P]=lu(A);
x = U\(L\P*b)