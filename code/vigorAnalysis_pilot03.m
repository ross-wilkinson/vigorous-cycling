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

t_ba = readtable('2021_05_28_10_29_16.csv');
t_n1 = readtable('2021_05_28_10_40_01.csv');
t_r1 = readtable('2021_05_28_10_49_56.csv');
t_r2 = readtable('2021_05_28_11_00_41.csv');
t_n2 = readtable('2021_05_28_11_10_37.csv');
t_tt = readtable('2021_05_28_11_20_12.csv');

%% Calculate finishing times
k_ba = t_ba.km > 1.0;
time_ba = min(t_ba.secs(k_ba));
k_n1 = t_n1.km > 1.0;
time_n1 = min(t_n1.secs(k_n1));
k_n2 = t_n2.km > 1.0;
time_n2 = min(t_n2.secs(k_n2));
k_r1 = t_r1.km > 1.0;
time_r1 = min(t_r1.secs(k_r1));
k_r2 = t_r2.km > 1.0;
time_r2 = min(t_r2.secs(k_r2));
k_tt = t_tt.km > 1.0;
time_tt = min(t_tt.secs(k_tt));

%% Set color palette
cBA = [25 25 25]/255;
cN1 = [228 26 28]/255;
cN2 = [255 127 0]/255;
cR1 = [55 126 184]/255;
cR2 = [77 175 74]/255;
cTT = [152 78 163]/255;

%% Plot finishing times
fig1 = figure('color','w');

scatter(1, time_ba, 80, cBA, 'filled')
hold on
scatter(2, time_n1, 80, cN1, 'filled')
scatter(3, time_r1, 80, cR1, 'filled')
scatter(4, time_r2, 80, cR2, 'filled')
scatter(5, time_n2, 80, cN2, 'filled')
scatter(6, time_tt, 80, cTT, 'filled')

ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:6;

maxTime = 150;

xlim([0 6])
% ylim([0 maxTime])
ylim([126 146])
box off
xlabel('Trial Number')
ylabel('Finishing Time (s)')
leg = legend('Baseline','Normal 1','Reward 1','Reward 2','Normal 2','Time Trial','location','best');
% leg.TextColor = 'w';
leg.Box = 'off';

%% Plot distance, velocity, power output, and cadence vs time
fig2 = figure('color','w','position',[50 50 310 620]);

w1 = 1;

%% distance
ax1 = subplot(411);
plot(t_ba.secs(~k_ba),t_ba.km(~k_ba)*1000,'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),t_n1.km(~k_n1)*1000,'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),t_r1.km(~k_r1)*1000,'color',cR1,'linewidth',w1)
plot(t_r2.secs(~k_r2),t_r2.km(~k_r2)*1000,'color',cR2,'linewidth',w1)
plot(t_n2.secs(~k_n2),t_n2.km(~k_n2)*1000,'color',cN2,'linewidth',w1)
plot(t_tt.secs(~k_tt),t_tt.km(~k_tt)*1000,'color',cTT,'linewidth',w1)

% ax1.Color = 'none';
% ax1.XColor = 'w';
% ax1.YColor = 'w';
ax1.YTick = 0:200:1000;

xlim([0 maxTime])
ylim([0 1000])
box off
ylabel('Distance (m)')
leg = legend('Baseline','Normal 1','Reward 1','Reward 2','Normal 2','Time Trial','location','best');
% leg.TextColor = 'w';
leg.Box = 'off';
leg.Position = [0.3 0.9 0 0];

%% velocity
ax2 = subplot(412);
plot(t_ba.secs(~k_ba),movmean(t_ba.kph(~k_ba)/3.6,[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.kph(~k_n1)/3.6,[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.kph(~k_r1)/3.6,[4 0]),'color',cR1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.kph(~k_r2)/3.6,[4 0]),'color',cR2,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.kph(~k_n2)/3.6,[4 0]),'color',cN2,'linewidth',w1)
plot(t_tt.secs(~k_tt),movmean(t_tt.kph(~k_tt)/3.6,[4 0]),'color',cTT,'linewidth',w1)

% ax2.Color = 'none';
% ax2.XColor = 'w';
% ax2.YColor = 'w';
ax2.YTick = 0:2:10;

xlim([0 maxTime])
ylim([0 10])
box off
ylabel('Velocity (m s^{-1})')

%% power output
ax3 = subplot(413);
plot(t_ba.secs(~k_ba),movmean(t_ba.watts(~k_ba),[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.watts(~k_n1),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.watts(~k_r1),[4 0]),'color',cR1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.watts(~k_r2),[4 0]),'color',cR2,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.watts(~k_n2),[4 0]),'color',cN2,'linewidth',w1)
plot(t_tt.secs(~k_tt),movmean(t_tt.watts(~k_tt),[4 0]),'color',cTT,'linewidth',w1)

% ax3.Color = 'none';
% ax3.XColor = 'w';
% ax3.YColor = 'w';
ax3.YTick = 0:60:300;

xlim([0 maxTime])
ylim([0 300])
box off
ylabel('Power Output (W)')

%% cadence
ax4 = subplot(414);
plot(t_ba.secs(~k_ba),movmean(t_ba.cad(~k_ba),[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.cad(~k_n1),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.cad(~k_r1),[4 0]),'color',cR1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.cad(~k_r2),[4 0]),'color',cR2,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.cad(~k_n2),[4 0]),'color',cN2,'linewidth',w1)
plot(t_tt.secs(~k_tt),movmean(t_tt.cad(~k_tt),[4 0]),'color',cTT,'linewidth',w1)

% ax4.Color = 'none';
% ax4.XColor = 'w';
% ax4.YColor = 'w';
ax4.YTick = 0:20:120;

xlim([0 maxTime])
ylim([0 120])
box off
xlabel('Time (s)')
ylabel('Cadence (RPM)')

%% Export figures
cd(resDir)
export_fig(fig1,'fig_pilot03_finishingTimes','-png','-eps','-cmyk','-r600')
export_fig(fig2,'fig_pilot03_timeSeries','-png','-eps','-cmyk','-r600')
