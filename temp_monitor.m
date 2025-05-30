function temp_monitor(a)
% Yixuan Ding
% ssyyd13@nottingham.edu.cn
%% temp_monitor.
%%doc temp_monitor: this function is designed that a Real-time temperature monitoring program
% displays a temperature-time chart on startup. Red light flashes every 0.25s above 24°C, 
% green stays lit between 18-24°C, and yellow flashes every 0.5s below 18°C.
red='D10';
green='D9';
yellow='D8';
V0 = 0.5;    % 0°C voltage V
TC = 0.01;   % coefficients mv/c

figure;
xlabel('Time (s)'); % x label
ylabel('Temperature (°C)'); %  y label
xtime= [];   % restore time
ytemp= [];   % restore temp
start_time = tic; % recorde start time
c=0;          %pause time
lasttime=0;   %last time draw picture
realtime=0;   %the current time
while true
    v=readVoltage(a,'A0');  %read data
    t=(v-V0)/TC;              %transfer voltage to temp
    elapsed_time = toc(start_time);
    realtime=elapsed_time+c;
    if realtime-lasttime>=1
    xtime = [xtime, realtime];    ytemp = [ytemp, t];
    plot(xtime,ytemp);
    xlim([max(0,realtime-10),realtime+1]);
    ylim([0,50]);
    drawnow;
    lasttime=realtime;
    end
    if t>=18&&t<=24          %tempreture in 18-24
        writeDigitalPin(a,green,1); %green on
        writeDigitalPin(a,red,0);   % red off
        writeDigitalPin(a,yellow,0);%yellow off
    else  if t<18
            writeDigitalPin(a,green,0);%green off
            writeDigitalPin(a,red,0);% red off
             writeDigitalPin(a,yellow,1);%yellow on
             pause(0.5);    %term
             writeDigitalPin(a,yellow,0);
             pause(0.5);
             c=c+1;
    else if t>24
            writeDigitalPin(a,green,0);%green off
            writeDigitalPin(a,red,1);% red on
            writeDigitalPin(a,yellow,0);%yellow off
             pause(0.25);      %term
             writeDigitalPin(a,red,0);
             pause(0.25);
             c=c+0.5;
    end
    end
    end
end

end
