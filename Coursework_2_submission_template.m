% Yixuan Ding
% ssyyd13@nottingham.edu.cn


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]

clc;clear all;
a = arduino;
for i=1:10                     %loop
 writeDigitalPin(a,'D8',1);    %light up led
    pause(0.5);                %pause for 0.5 second
    writeDigitalPin(a,'D8',0); %light off led
    pause(0.5);                %pause for 0.5 second
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

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
time=0:(n-1);            %time
plot(time,t);            %plot point
xlabel('Time (s)');      %x label
ylabel('Tempreture(°C)') %y label
title('Temperature vs. Time');  %title

%d
shuchu=sprintf('Data logging initiated-23/4/2025,\nLocation ，Nottingham\n\n');%print title

for j=0:10            %loop
    k=j*60;    
    if(k==0)          %the 0 second
        temp=t(k+1);
    else
    temp=t(k);        
    end
    shuchu=sprintf('%sMinute\t\t\t%d\nTempreature \t%.2f C\n\n',shuchu,j,temp);  %print body
end

shuchu=sprintf('%sMax temp\t\t%.2fC\nMin temp\t\t%.2fC\nAverage temp\t%.2fC',shuchu,max_t,min_t,avg_t);

shuchu=sprintf('%s\n\nData logging terminated\n\n',shuchu);   % tail

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
disp(content);     % the txt file content

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
clc;clear all;
a = arduino; %initialize
temp_monitor(a);


%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

clc;clear all;
a = arduino; %initialize
temp_prediction(a);


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% I encountered numerous challenges during this process. For instance,
% it was my first time using GitHub and assembling an Arduino. While coding, 
% I faced difficulties such as maintaining timing consistency in Task 2. 
% However, my strengths lie in coding familiarity and having developed strong programming logic through continuous learning. My limitation is relatively lower coding efficiency.
% Moving forward, I aim to master MATLAB workflows more proficiently, 
% while also committing to self-directed learning to deepen my MATLAB knowledge base.