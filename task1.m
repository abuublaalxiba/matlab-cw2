% Yixuan Ding
% ssyyd13@nottingham.edu.cn
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
%b
clc;clear all;
a = arduino; %initialize
V0 = 0.5;    % 0°C voltage V
TC = 0.01;   % coefficients mv/c
duration=600;      %Create a variable “duration” with value 60
interval_time=1; n=duration/interval_time; %set interval time
v=zeros(1,n);t=zeros(1,n);% Create the arrays that will contain the acquired data. 
for i=1:n
    v(i)=readVoltage(a,'A0'); %record A0 data
    t(i)=(v(i)-V0)/TC;
    pause(interval_time); %transfer voltage to tempreture
end
min_t = min(t);        %get min tempreture
max_t = max(t);        %get max tempreture
avg_t = mean(t);       %get average tempreture

%c
time=0:(n-1);
plot(time,t);
xlabel('Time (s)');
ylabel('Tempreture(°C)')
title('Temperature vs. Time');

%d
shuchu=sprintf('Data logging initiated-23/4/2025,\nLocation ，Nottingham\n\n');%print title

for j=0:10
    k=j*60;
    if(k==0)
        temp=t(k+1);
    else
    temp=t(k);
    end
    shuchu=sprintf('%sMinute\t\t\t%d\nTempreature \t%.2f C\n\n',shuchu,j,temp);
end

shuchu=sprintf('%sMax temp\t\t%.2f c\nMin temp\t\t%.2fC\nAverage temp\t%.2fC',shuchu,max_t,min_t,avg_t);

shuchu=sprintf('%s\n\nData logging terminated\n\n',shuchu);

fprintf('%s',shuchu);

%e
% write in
txtfile = fopen('cabin_temperature.txt', 'w');

% check
if txtfile == -1
    error('cannot open cabin_temperature.txt ');
end

% write data
fprintf(txtfile, '%s', shuchu);

% close file
fclose(txtfile);

%check
txtfile=fopen('cabin_temperature.txt', 'r');
if txtfile == -1
    error('cannot open cabin_temperature.txt ');
end

content = fread(txtfile, '*char')';

fclose(txtfile);
disp('the content as follows');
disp(content);