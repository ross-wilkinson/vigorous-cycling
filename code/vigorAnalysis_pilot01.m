%% Process vigorous cycling pilot data
% Calculate exact finishing times and create plots of time series data

%% Initialize 
clear; clc; close all

%% Set directories
expDir = '/Users/rosswilkinson/Google Drive/projects/vigorous-cycling/';
datDir = [expDir '/data'];
codDir = [expDir '/matlab'];
docDir = [expDir '/docs'];
resDir = [expDir '/results'];

%% Load data
cd(datDir)

t_r1 = readtable('2021_04_29_13_26_34.csv');
t_n1 = readtable('2021_04_29_13_34_46.csv');
t_n2 = readtable('2021_04_29_13_43_13.csv');
t_r2 = readtable('2021_04_29_13_52_20.csv');
t_t1 = readtable('2021_04_29_14_01_59.csv');

%% Calculate finishing times
k_n1 = t_n1.km > 1.609;
time_n1 = min(t_n1.secs(k_n1));
k_n2 = t_n2.km > 1.609;
time_n2 = min(t_n2.secs(k_n2));
k_r1 = t_r1.km > 1.609;
time_r1 = min(t_r1.secs(k_r1));
k_r2 = t_r2.km > 1.609;
time_r2 = min(t_r2.secs(k_r2));
k_t1 = t_t1.km > 1.609;
time_t1 = min(t_t1.secs(k_t1));

%% Set color palette
c1a = [230 97 1]/255;
c1b = [253 184 99]/255;
c2a = [94 60 153]/255;
c2b = [178 171 210]/255;
c3 = [247 247 247]/255;

%% Plot finishing times
figure('color','none')

scatter(1, time_r1, 50, c2a, 'filled')
hold on
scatter(2, time_n1, 50, c1a, 'filled')
scatter(3, time_n2, 50, c1b, 'filled')
scatter(4, time_r2, 50, c2b, 'filled')
scatter(5, time_t1, 50, c3, 'filled')

ax = gca;
ax.Color = 'none';
ax.XColor = 'w';
ax.YColor = 'w';
ax.XTick = 0:5;

xlim([0 5])
ylim([0 400])
box off
xlabel('Trial Number')
ylabel('Finishing Time (s)')
leg = legend('Reward 1','Normal 1','Normal 2','Reward 2','Time Trial','location','best');
leg.TextColor = 'w';
leg.Box = 'off';

%% Plot distance, velocity, power output, and cadence vs time
figure('color','none','position',[50 50 310 620])

w1 = 1;

% distance
ax1 = subplot(411);
plot(t_n1.secs(~k_n1),t_n1.km(~k_n1)*1000,'color',c1a,'linewidth',w1)
hold on
plot(t_n2.secs(~k_n2),t_n2.km(~k_n2)*1000,'color',c1b,'linewidth',w1)
plot(t_r1.secs(~k_r1),t_r1.km(~k_r1)*1000,'color',c2a,'linewidth',w1)
plot(t_r2.secs(~k_r2),t_r2.km(~k_r2)*1000,'color',c2b,'linewidth',w1)
plot(t_t1.secs(~k_t1),t_t1.km(~k_t1)*1000,'color',c3,'linewidth',w1)

ax1.Color = 'none';
ax1.XColor = 'w';
ax1.YColor = 'w';

ylim([0 1610])
box off
ylabel('Distance (m)')
leg = legend('Normal 1','Normal 2','Reward 1','Reward 2','Time Trial','location','best');
leg.TextColor = 'w';
leg.Box = 'off';

% velocity
ax2 = subplot(412);
plot(t_n1.secs(~k_n1),movmean(t_n1.kph(~k_n1)/3.6,[2 0]),'color',c1a,'linewidth',2)
hold on
plot(t_n2.secs(~k_n2),movmean(t_n2.kph(~k_n2)/3.6,[2 0]),'color',c1b,'linewidth',2)
plot(t_r1.secs(~k_r1),movmean(t_r1.kph(~k_r1)/3.6,[2 0]),'color',c2a,'linewidth',2)
plot(t_r2.secs(~k_r2),movmean(t_r2.kph(~k_r2)/3.6,[2 0]),'color',c2b,'linewidth',2)
plot(t_t1.secs(~k_t1),movmean(t_t1.kph(~k_t1)/3.6,[2 0]),'color',c3,'linewidth',2)

ax2.Color = 'none';
ax2.XColor = 'w';
ax2.YColor = 'w';

ylim([0 6])
box off
ylabel('Velocity (m s^{-1})')

% power output
ax3 = subplot(413);
plot(t_n1.secs(~k_n1),movmean(t_n1.watts(~k_n1),[2 0]),'color',c1a,'linewidth',2)
hold on
plot(t_n2.secs(~k_n2),movmean(t_n2.watts(~k_n2),[2 0]),'color',c1b,'linewidth',2)
plot(t_r1.secs(~k_r1),movmean(t_r1.watts(~k_r1),[2 0]),'color',c2a,'linewidth',2)
plot(t_r2.secs(~k_r2),movmean(t_r2.watts(~k_r2),[2 0]),'color',c2b,'linewidth',2)
plot(t_t1.secs(~k_t1),movmean(t_t1.watts(~k_t1),[2 0]),'color',c3,'linewidth',2)

ax3.Color = 'none';
ax3.XColor = 'w';
ax3.YColor = 'w';

ylim([0 220])
box off
ylabel('Power Output (W)')

% cadence
ax4 = subplot(414);
plot(t_n1.secs(~k_n1),movmean(t_n1.cad(~k_n1),[2 0]),'color',c1a,'linewidth',2)
hold on
plot(t_n2.secs(~k_n2),movmean(t_n2.cad(~k_n2),[2 0]),'color',c1b,'linewidth',2)
plot(t_r1.secs(~k_r1),movmean(t_r1.cad(~k_r1),[2 0]),'color',c2a,'linewidth',2)
plot(t_r2.secs(~k_r2),movmean(t_r2.cad(~k_r2),[2 0]),'color',c2b,'linewidth',2)
plot(t_t1.secs(~k_t1),movmean(t_t1.cad(~k_t1),[2 0]),'color',c3,'linewidth',2)

ax4.Color = 'none';
ax4.XColor = 'w';
ax4.YColor = 'w';
ax4.YTick = 0:25:100;

ylim([0 100])
box off
xlabel('Time (s)')
ylabel('Cadence (RPM)')
