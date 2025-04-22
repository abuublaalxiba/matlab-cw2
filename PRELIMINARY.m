% Yixuan Ding
% ssyyd13@nottingham.edu.cn
%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clc;clear all;
a = arduino;
for i=1:10                     %loop
 writeDigitalPin(a,'D7',1);    %light up led
    pause(0.5);                %pause for 0.5 second
    writeDigitalPin(a,'D7',0); %light off led
    pause(0.5);                %pause for 0.5 second
end

