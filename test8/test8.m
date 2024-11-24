clearvars

%% problem 1
syms x y z

z = (x+1)./(sqrt(3+x)-y);

z = subs(z,x,6);
subs(z,y,5)

clearvars x y z

%% problem 2
% problem 2-1
syms beta1 beta2
f = cos(beta1)*cos(beta2)+sin(beta1)*sin(beta2);
simplify(f)

clearvars beta1 beta2 f
% problem 2-2
syms x
p = (4*x^2+8*x+3)/(1+2*x);
simplify(p)

clearvars x p

%% problem 3
syms x a t

% problem 3-1 
f = (x*(exp(sin(x))+1)-2*(exp(tan(x))-1))/(sin(x)^3);
limit(f,x,0)

% problem 3-2
f = (sqrt(x)-sqrt(acos(x)))/(sqrt(1+x));
limit(f,x,1,"right")

% problem 3-3
y = (1-cos(2*x))/(x);
diff(y)
diff(y,2)

% problem 3-4
A = [a^x        t^3;
     t*cos(x)   log(x)];

dAdx = diff(A,x)
d2Adt2 = diff(A,t,2)
dAdxdt = diff(dAdx,t)

clearvars