% Yixuan Ding
% ssyyd13@nottingham.edu.cn
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clc;clear all;
a = arduino; %initialize
V0 = 0.5;    % 0°C voltage V
TC = 0.01;   % coefficients mv/c
duration=600;      %Create a variable “duration” with value 60
interval_time=1; n=duration/interval_time; %set interval time
v=zeros(1,n);t=zeros(1,n);% Create the arrays that will contain the acquired data. 
for i=1:n
    v(i)=readvoltage(a,'A0'); %record A0 data
    t(i)=(v(i)-V0)/TC;
    pause(interval_time); %transfer voltage to tempreture
end
min_t = min(t);        %get min tempreture
max_t = max(t);        %get max tempreture
avg_t = mean(t);       %get average tempreture