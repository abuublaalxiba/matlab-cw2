function temp_prediction(a)
% Yixuan Ding
% ssyyd13@nottingham.edu.cn
%%doc temp_prediction:Real-time temperature rate monitor: Red light at +4°C/min rise, yellow at -4°C/min drop, green otherwise. 
% Forecasts 5-minute temperature and displays current temp, rate, and prediction on-screen.
%% temp_prediction
red='D10';
green='D9';
yellow='D8';
V0 = 0.5;    % 0°C voltage V
TC = 0.01;   % coefficients mv/c
temp=30;
    last_temp   = temp;
    last_time   = tic;
    rate_smooth = [];
    temphistory=[];
while true
v=readVoltage(a,'A0');           %read data
    temp=(v-V0)/TC;              %transfer voltage to temp
dt = toc(last_time);             % dt
last_time = tic;                 % record time
rate=(last_temp-temp)/dt;        %get rate
rate_smooth=[rate_smooth,rate]; %rate history
temphistory=[temphistory,temp]; %temp history
if numel(rate_smooth)>5
    rate_smooth=rate_smooth(end-4:end)/5;  %use mean number to smooth rate
end

newrate=mean(rate_smooth);
temp=mean(temphistory);
predicted_temp = temp+newrate * 300;
if newrate>=4/60
    writeDigitalPin(a,green,0);%green off
            writeDigitalPin(a,red,1);% red on
            writeDigitalPin(a,yellow,0);%yellow off
elseif newrate<=-4/60
        writeDigitalPin(a,green,0);%green off
            writeDigitalPin(a,red,0);% red off
             writeDigitalPin(a,yellow,1);%yellow on
else 
    writeDigitalPin(a,green,1); %green on
        writeDigitalPin(a,red,0);   % red off
        writeDigitalPin(a,yellow,0);%yellow off
end


fprintf('current temp: %.2f°C\n',temp)
fprintf('the preidict temp: %.2f°C\n', predicted_temp)
fprintf('the temp rate: %.3f°C/s\n', newrate)
last_temp=temp;
pause(1); %per second calculate once
end
end

