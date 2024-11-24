% Copyright (c) 2024 by Central South University.                   
% coding: utf-8                                                     
% programme written by Yaokun Yang, 
% github repository:
% <https://github.com/PourRevenir/Scientific-Calculation-and-MATLAB.git>.
% For more information, contact by email: <yangyaokun@csu.edu.cn>.  
% Please read the README.md before use.                             
%-------------------------------------------------------------------

clearvars
uiopen('os110306_11.dat',1)
% Import range: C1,C518400
% Import type: matrix

%% Fourier transform
a = fft(os11030611);


%% figure
figure(1)
subplot(2,1,1)
plot(os11030611,'k')
grid on
subplot(2,1,2)
plot(abs(a),'k')
grid on