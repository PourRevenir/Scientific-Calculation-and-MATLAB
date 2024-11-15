clearvars;

%% problem 1
t = 6:2:18;
T1 = [18.0	20.0	22.0	25.0	30.0	28.0	24.0];
T2 = [15.0	19.0	24.0	28.0	34.0	32.0	30.0];

tq = 6:0.5:18;
T1q = spline(t,T1,tq);
T2q = spline(t,T2,tq);

T1q(2:4:24)
T2q(2:4:24)

clearvars t T1 T2 tq T1q T2q
%% problem 2
x = 1:10:101;
lgx = [0	1.0414	1.3222	1.4914	1.6128	1.7076	1.7853	1.8513	1.9085	1.9590	2.0043];

p = polyfit(x,lgx,5);
xx = 1:0.5:101;
poly5lgx = zeros(1,length(xx));
for i = 1:6
    poly5lgx = p(i)*xx.^(6-i) + poly5lgx;
end

plot(xx,poly5lgx,'k','LineWidth',1.2);hold on
plot(x,lgx,'ro');grid on
legend('5次多项式拟合','采样点');
xlim([0,101]);

clearvars x xx lgx poly5lgx p i

%% problem 3
poly1 = [1 2 4 0 5];    % P1 = x^4+2x^3+4x^2+5
poly2 = [1 2];          % P2 = x + 2
poly3 = [1 2 3];        % P3 = x^2 + 2x + 3

% problem 3-1
poly = poly1 + [0 conv(poly2,poly3)]

% problem 3-2
roots(poly)

% problem 3-3
A = [-1         1.2     -1.4;
     0.75       2       3.5;
     0          5       2.5];
polyA = zeros(1,9);
for i = 1:9
    polyA(i) = polyval(poly,A(i));
end
polyA

% problem 3-4
polyvalm(poly,A)
