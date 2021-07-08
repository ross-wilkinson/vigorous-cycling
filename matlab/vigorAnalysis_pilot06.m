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

t_ba = readtable('2021_07_07_13_21_15.csv');
t_n1 = readtable('2021_07_07_13_24_23.csv');
t_n2 = readtable('2021_07_07_13_29_25.csv');
t_r1 = readtable('2021_07_07_13_35_17.csv');
t_n3 = readtable('2021_07_07_13_42_44.csv');
t_n4 = readtable('2021_07_07_13_50_01.csv');
t_r2 = readtable('2021_07_07_13_54_07.csv');
t_tt = readtable('2021_07_07_13_59_11.csv');

%% Calculate finishing times
distance = 0.4;

k_ba_start = find(t_ba.km > 0, 1, 'first');
k_ba_end = find(t_ba.km > distance, 1, 'first');
time_ba = t_ba.secs(k_ba_end) - t_ba.secs(k_ba_start);

k_n1_start = find(t_n1.km > 0, 1, 'first');
k_n1_end = find(t_n1.km > distance, 1, 'first');
time_n1 = t_n1.secs(k_n1_end) - t_n1.secs(k_n1_start);

k_n2_start = find(t_n2.km > 0, 1, 'first');
k_n2_end = find(t_n2.km > distance, 1, 'first');
time_n2 = t_n2.secs(k_n2_end) - t_n2.secs(k_n2_start);

k_r1_start = find(t_r1.km > 0, 1, 'first');
k_r1_end = find(t_r1.km > distance, 1, 'first');
time_r1 = t_r1.secs(k_r1_end) - t_r1.secs(k_r1_start);

k_n3_start = find(t_n3.km > 0, 1, 'first');
k_n3_end = find(t_n3.km > distance, 1, 'first');
time_n3 = t_n3.secs(k_n3_end) - t_n3.secs(k_n3_start);

k_n4_start = find(t_n4.km > 0, 1, 'first');
k_n4_end = find(t_n4.km > distance, 1, 'first');
time_n4 = t_n4.secs(k_n4_end) - t_n4.secs(k_n4_start);

k_r2_start = find(t_r2.km > 0, 1, 'first');
k_r2_end = find(t_r2.km > distance, 1, 'first');
time_r2 = t_r2.secs(k_r2_end) - t_r2.secs(k_r2_start);

k_tt_start = find(t_tt.km > 0, 1, 'first');
k_tt_end = find(t_tt.km > distance, 1, 'first');
time_tt = t_tt.secs(k_tt_end) - t_tt.secs(k_tt_start);

% k_n1 = t_n1.km > distance;
% time_n1 = min(t_n1.secs(k_n1));
% k_n2 = t_n2.km > distance;
% time_n2 = min(t_n2.secs(k_n2));
% k_r1 = t_r1.km > distance;
% time_r1 = min(t_r1.secs(k_r1));
% k_n3 = t_n3.km > distance;
% time_n3 = min(t_n3.secs(k_n3));
% k_n4 = t_n4.km > distance;
% time_n4 = min(t_n4.secs(k_n4));
% k_r2 = t_r2.km > distance;
% time_r2 = min(t_r2.secs(k_r2));
% k_tt = t_tt.km > distance;
% time_tt = min(t_tt.secs(k_tt));

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
scatter(3, time_n2, 80, cN1, 'filled')
scatter(4, time_r1, 80, cR1, 'filled')
scatter(5, time_n3, 80, cN2, 'filled')
scatter(6, time_n4, 80, cN1, 'filled')
scatter(7, time_r2, 80, cR1, 'filled')
scatter(8, time_tt, 80, cTT, 'filled')

ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:8;
ax.XTickLabels = {'','Baseline','N1','N2','R1','N3','N4','R2','TT',''};

maxTime = 90;

xlim([0 8])
ylim([0 maxTime])
% ylim([40 maxTime])
box off
% xlabel('Trial Number')
ylabel('Finishing Time (s)')
% leg = legend('Baseline','Normal 1','Normal 2','Reward 1','Normal 3','Normal 4','Reward 2','Time Trial','location','best');
% leg.TextColor = 'w';
% leg.Box = 'off';

%% Plot distance, velocity, power output, and cadence vs time
fig2 = figure('color','w','position',[50 50 310 620]);

w1 = 1;

%% distance
ax1 = subplot(411);
plot(t_ba.secs(~k_ba),t_ba.km(~k_ba)*1000,'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),t_n1.km(~k_n1)*1000,'color',cN1,'linewidth',w1)
plot(t_n2.secs(~k_n2),t_n2.km(~k_n2)*1000,'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),t_r1.km(~k_r1)*1000,'color',cR1,'linewidth',w1)
plot(t_n3.secs(~k_n3),t_n3.km(~k_n3)*1000,'color',cN2,'linewidth',w1)
plot(t_n4.secs(~k_n4),t_n4.km(~k_n4)*1000,'color',cN1,'linewidth',w1)
plot(t_r2.secs(~k_r2),t_r2.km(~k_r2)*1000,'color',cR1,'linewidth',w1)
plot(t_tt.secs(~k_tt),t_tt.km(~k_tt)*1000,'color',cTT,'linewidth',w1)

% ax1.Color = 'none';
% ax1.XColor = 'w';
% ax1.YColor = 'w';
% ax1.YTick = 0:200:1000;

xlim([0 maxTime])
ylim([0 400])
box off
ylabel('Distance (m)')
leg = legend('Baseline','Normal 1','Normal 2','Reward 1','Normal 3','Normal 4','Reward 2','Time Trial','location','best');
% leg.TextColor = 'w';
leg.Box = 'off';
leg.Position = [0.3 0.9 0 0];

%% velocity
ax2 = subplot(412);
plot(t_ba.secs(~k_ba),movmean(t_ba.kph(~k_ba)/3.6,[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.kph(~k_n1)/3.6,[4 0]),'color',cN1,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.kph(~k_n2)/3.6,[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.kph(~k_r1)/3.6,[4 0]),'color',cR1,'linewidth',w1)
plot(t_n3.secs(~k_n3),movmean(t_n3.kph(~k_n3)/3.6,[4 0]),'color',cN2,'linewidth',w1)
plot(t_n4.secs(~k_n4),movmean(t_n4.kph(~k_n4)/3.6,[4 0]),'color',cN1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.kph(~k_r2)/3.6,[4 0]),'color',cR1,'linewidth',w1)
plot(t_tt.secs(~k_tt),movmean(t_tt.kph(~k_tt)/3.6,[4 0]),'color',cTT,'linewidth',w1)

% ax2.Color = 'none';
% ax2.XColor = 'w';
% ax2.YColor = 'w';
ax2.YTick = 0:2:12;

xlim([0 maxTime])
ylim([0 12])
box off
ylabel('Velocity (m s^{-1})')

%% power output
ax3 = subplot(413);
plot(t_ba.secs(~k_ba),movmean(t_ba.watts(~k_ba),[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.watts(~k_n1),[4 0]),'color',cN1,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.watts(~k_n2),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.watts(~k_r1),[4 0]),'color',cR1,'linewidth',w1)
plot(t_n3.secs(~k_n3),movmean(t_n3.watts(~k_n3),[4 0]),'color',cN2,'linewidth',w1)
plot(t_n4.secs(~k_n4),movmean(t_n4.watts(~k_n4),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.watts(~k_r2),[4 0]),'color',cR1,'linewidth',w1)
plot(t_tt.secs(~k_tt),movmean(t_tt.watts(~k_tt),[4 0]),'color',cTT,'linewidth',w1)

% ax3.Color = 'none';
% ax3.XColor = 'w';
% ax3.YColor = 'w';
ax3.YTick = 0:100:500;

xlim([0 maxTime])
ylim([0 500])
box off
ylabel('Power Output (W)')

%% cadence
ax4 = subplot(414);
plot(t_ba.secs(~k_ba),movmean(t_ba.cad(~k_ba),[4 0]),'color',cBA,'linewidth',w1)
hold on
plot(t_n1.secs(~k_n1),movmean(t_n1.cad(~k_n1),[4 0]),'color',cN1,'linewidth',w1)
plot(t_n2.secs(~k_n2),movmean(t_n2.cad(~k_n2),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r1.secs(~k_r1),movmean(t_r1.cad(~k_r1),[4 0]),'color',cR1,'linewidth',w1)
plot(t_n3.secs(~k_n3),movmean(t_n3.cad(~k_n3),[4 0]),'color',cN2,'linewidth',w1)
plot(t_n4.secs(~k_n4),movmean(t_n4.cad(~k_n4),[4 0]),'color',cN1,'linewidth',w1)
plot(t_r2.secs(~k_r2),movmean(t_r2.cad(~k_r2),[4 0]),'color',cR1,'linewidth',w1)
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

%% Plot average cadence
fig3 = figure('color','w');

scatter(1, mean(t_ba.cad(~k_ba)), 80, cBA, 'filled')
hold on
scatter(2, mean(t_n1.cad(~k_n1)), 80, cN1, 'filled')
scatter(3, mean(t_n2.cad(~k_n2)), 80, cN1, 'filled')
scatter(4, mean(t_r1.cad(~k_r1)), 80, cR1, 'filled')
scatter(5, mean(t_n3.cad(~k_n3)), 80, cN2, 'filled')
scatter(6, mean(t_n4.cad(~k_n4)), 80, cN1, 'filled')
scatter(7, mean(t_r2.cad(~k_r2)), 80, cR1, 'filled')
scatter(8, mean(t_tt.cad(~k_tt)), 80, cTT, 'filled')

ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:8;
ax.XTickLabels = {'','Baseline','N1','N2','R1','N3','N4','R2','TT',''};

maxCad = 100;

xlim([0 8])
ylim([0 maxCad])
% ylim([60 maxCad])
box off
xlabel('Trial Number')
ylabel('Mean Cadence (RPM)')
% leg = legend('Baseline','Normal 1','Normal 2','Reward 1','Normal 3','Normal 4','Reward 2','Time Trial','location','best');
% leg.TextColor = 'w';
% leg.Box = 'off';

%% Plot mean power
fig4 = figure('color','w');

scatter(1, mean(t_ba.watts(~k_ba)), 80, cBA, 'filled')
hold on
scatter(2, mean(t_n1.watts(~k_n1)), 80, cN1, 'filled')
scatter(3, mean(t_n2.watts(~k_n2)), 80, cN1, 'filled')
scatter(4, mean(t_r1.watts(~k_r1)), 80, cR1, 'filled')
scatter(5, mean(t_n3.watts(~k_n3)), 80, cN2, 'filled')
scatter(6, mean(t_n4.watts(~k_n4)), 80, cN1, 'filled')
scatter(7, mean(t_r2.watts(~k_r2)), 80, cR1, 'filled')
scatter(8, mean(t_tt.watts(~k_tt)), 80, cTT, 'filled')

ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:8;
ax.XTickLabels = {'','Baseline','N1','N2','R1','N3','N4','R2','TT',''};

maxPwr = 400;

xlim([0 8])
ylim([0 maxPwr])
% ylim([50 maxPwr])
box off
xlabel('Trial Number')
ylabel('Mean Power (W)')
% leg = legend('Baseline','Normal 1','Normal 2','Reward 1','Normal 3','Normal 4','Reward 2','Time Trial','location','best');
% leg.TextColor = 'w';
% leg.Box = 'off';

%% Plot mean torque
fig5 = figure('color','w');

trq_ba = mean(t_ba.watts(~k_ba)) / (mean(t_ba.cad(~k_ba)) / 60 * 2 * pi);
trq_n1 = mean(t_n1.watts(~k_n1)) / (mean(t_n1.cad(~k_n1)) / 60 * 2 * pi);
trq_n2 = mean(t_n2.watts(~k_n2)) / (mean(t_n2.cad(~k_n2)) / 60 * 2 * pi);
trq_r1 = mean(t_r1.watts(~k_r1)) / (mean(t_r1.cad(~k_r1)) / 60 * 2 * pi);
trq_n3 = mean(t_n3.watts(~k_n3)) / (mean(t_n3.cad(~k_n3)) / 60 * 2 * pi);
trq_n4 = mean(t_n4.watts(~k_n4)) / (mean(t_n4.cad(~k_n4)) / 60 * 2 * pi);
trq_r2 = mean(t_r2.watts(~k_r2)) / (mean(t_r2.cad(~k_r2)) / 60 * 2 * pi);
trq_tt = mean(t_tt.watts(~k_tt)) / (mean(t_tt.cad(~k_tt)) / 60 * 2 * pi);

scatter(1, trq_ba, 80, cBA, 'filled')
hold on
scatter(2, trq_n1, 80, cN1, 'filled')
scatter(3, trq_n2, 80, cN1, 'filled')
scatter(4, trq_r1, 80, cR1, 'filled')
scatter(5, trq_n3, 80, cN2, 'filled')
scatter(6, trq_n4, 80, cN1, 'filled')
scatter(7, trq_r2, 80, cR1, 'filled')
scatter(8, trq_tt, 80, cTT, 'filled')

ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:8;
ax.XTickLabels = {'','Baseline','N1','N2','R1','N3','N4','R2','TT',''};

maxTrq = 40;

xlim([0 8])
ylim([0 maxTrq])
% ylim([50 maxPwr])
box off
xlabel('Trial Number')
ylabel('Mean Torque (N m)')
% leg = legend('Baseline','Normal 1','Normal 2','Reward 1','Normal 3','Normal 4','Reward 2','Time Trial','location','best');
% leg.TextColor = 'w';
% leg.Box = 'off';

%% Export figures
cd(resDir)
export_fig(fig1,'fig_pilot06_finishingTimes','-png','-eps','-cmyk','-r600')
export_fig(fig2,'fig_pilot06_timeSeries','-png','-eps','-cmyk','-r600')
export_fig(fig3,'fig_pilot06_meanCadence','-png','-eps','-cmyk','-r600')
export_fig(fig4,'fig_pilot06_meanPower','-png','-eps','-cmyk','-r600')
export_fig(fig5,'fig_pilot06_meanTorque','-png','-eps','-cmyk','-r600')
