clearvars;

%% problem 1
x = linspace(0,1,10);
data = [x;exp(x)];

mytxt = fopen('my.txt','w');
fprintf(mytxt,'%f %f\n',data);
fclose(mytxt);
%% 

load('my.txt')
my

%% problem 2
demo = detectImportOptions('textdemo.txt');
demo.DataLines = [2 5];
demo.VariableNames = {'Name','English','Chinese','Mathematics'};
table = readtable('textdemo.txt',demo) 

%%
[xq,yq] = meshgrid(0:0.01:9,0:0.01:7);
vq = griddata(Demogrid.Easting,Demogrid.Northing,Demogrid.Elvation,xq,yq,'v4');
mesh(xq,yq,vq);
contourf(xq,yq,vq)