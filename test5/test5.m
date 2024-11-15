clearvars;

%% problem 1
x = -5:0.01:5;
y = ((x+sqrt(pi))./exp(2)).*(x<=0) + (0.5*log(x+sqrt(1+x.^2))).*(x>0);
plot(x,y,'k','LineWidth',1.3);grid on

clearvars x y

%% problem 2
a = 2;
b = 0.25*pi;
n = 2;

theta = 0:0.01:2*pi;
rho = a*sin(n*theta+b);

polarplot(theta,rho,'k','LineWidth',1.3);

clearvars a b n theta rho

%% problem 3
x = linspace(-5,5,21);
y = linspace(0,10,31);
[X,Y] = meshgrid(x,y);

z = cos(X).*cos(Y).*exp(-0.25*sqrt(X.^2+Y.^2));

figure(1);
subplot(2,1,1);
surf(X,Y,z);
colorbar;
xlabel('x');
ylabel('y');
zlabel('z');

subplot(2,1,2)
contourf(X,Y,z);
colorbar;
xlabel('x');
ylabel('y');

clearvars x y z X Y

%% problem 4
x = linspace(0,2*pi,101);
y = (0.5+3*sin(x)./(1+x.^2)).*cos(x);

plot(x,y,'k','LineWidth',1.3);grid on
xlim([0,2*pi]);

clearvars x y

%% problem 5
x = linspace(-5,5,100);
y1 = x.^2;
y2 = cos(x);
y3 = y1.*y2;

% problem 5-1
figure(1);
plot(x,y1,'LineWidth',1.3);hold on
plot(x,y2,'LineWidth',1.3);hold on
plot(x,y3,'LineWidth',1.3);grid on
legend('y_1','y_2','y_3');
xlabel('x');
ylabel('y');

% problem 5-2
figure(2);
subplot(3,1,1);
plot(x,y1,'LineWidth',1.3);grid on
ylabel('y_1');
subplot(3,1,2);
plot(x,y2,'LineWidth',1.3);grid on
ylabel('y_2');
subplot(3,1,3);
plot(x,y3,'LineWidth',1.3);grid on
ylabel('y_3');
xlabel('x');

% problem 5-3
figure(3)
subplot(3,1,1);
bar(x,y1);grid on
ylabel('y_1');
subplot(3,1,2);
area(x,y2);grid on
ylabel('y_2');
subplot(3,1,3);
stem(x,y3);grid on
ylabel('y_3');
xlabel('x');

clearvars x y1 y2 y3

%% problem 6
s = linspace(0,0.5*pi,50);
t = linspace(1,1.5*pi,50);

x = cos(s).*cos(t);
y = cos(s).*sin(t);
z = sin(s);

[xq,yq] = meshgrid(-1:0.01:1,-1:0.01:1);
zq = griddata(x,y,z,xq,yq,'v4');

figure(1);
surf(xq,yq,zq);shading interp
colorbar;
xlabel('x');
ylabel('y');
zlabel('z');

clearvars s t x y z xq yq zq
