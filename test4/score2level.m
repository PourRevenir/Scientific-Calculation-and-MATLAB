function y = score2level(x)
%SCORE2LEVEL 分数转换为对应的成绩等级
%   90分~100分为A，80分~89分为B，70分~79分为C，60分~69分为D，60分以下为E。

%% if-else
if(x >= 90 && x<=100)
    y = 'A';
elseif(x >= 80 && x<90)
    y = 'B';
elseif(x >= 70 && x<80)
    y = 'C';
elseif(x >= 60 && x<70)
    y = 'D';
elseif(x<60)
    y = 'E';
else
    disp('输入的分数可能存在错误');
end

%% switch-case 
% a = 90:100;
% a = num2cell(a);
% b = 80:89;
% b = num2cell(b);
% c = 70:79;
% c = num2cell(c);
% d = 60:69;
% d = num2cell(d);
% e = 0:59;
% e = num2cell(e);
% switch x
%     case a
%         y = 'A';
%     case b
%         y = 'B';
%     case c
%         y = 'C';
%     case d
%         y = 'D';
%     case e
%         y = 'E';
%     otherwise
%         disp('输入的分数可能存在错误');
% end
end