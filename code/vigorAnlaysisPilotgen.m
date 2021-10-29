%% Process vigorous cycling pilot data
% Calculate exact finishing times and create plots of time series data

%% Initialize 
clear; clc; close all

%% Set directories
expDir = '..';
datDir = [expDir '/data'];
codDir = [expDir '/matlab'];
docDir = [expDir '/docs'];
resDir = [expDir '/results'];


%% Load data
cd(datDir)
addpath(genpath(codDir));

% pilot 4
% t_ba = readtable('2021_06_18_14_15_23.csv');
% t_n1 = readtable('2021_06_18_14_20_37.csv');
% t_n2 = readtable('2021_06_18_14_25_44.csv');
% t_r1 = readtable('2021_06_18_14_34_13.csv');
% t_n3 = readtable('2021_06_18_14_40_57.csv');
% t_n4 = readtable('2021_06_18_14_45_20.csv');
% t_r2 = readtable('2021_06_18_14_51_05.csv');
% t_tt = readtable('2021_06_18_14_57_10.csv');

%pilot5 
% t_ba = readtable('2021_07_02_13_25_46.csv');
% t_n1 = readtable('2021_07_02_13_32_56.csv');
% t_n2 = readtable('2021_07_02_13_39_25.csv');
% t_r1 = readtable('2021_07_02_13_46_15.csv');
% t_n3 = readtable('2021_07_02_13_54_04.csv');
% t_n4 = readtable('2021_07_02_14_01_26.csv');
% t_r2 = readtable('2021_07_02_14_08_10.csv');
% t_tt = readtable('2021_07_02_14_14_54.csv');

%pilot6
% t_ba = readtable('2021_07_07_13_21_15.csv');
% t_n1 = readtable('2021_07_07_13_24_23.csv');
% t_n2 = readtable('2021_07_07_13_29_25.csv');
% t_r1 = readtable('2021_07_07_13_35_17.csv');
% t_n3 = readtable('2021_07_07_13_42_44.csv');
% t_n4 = readtable('2021_07_07_13_50_01.csv');
% t_r2 = readtable('2021_07_07_13_54_07.csv');
% t_tt = readtable('2021_07_07_13_59_11.csv');

%pilot7
t_ba = readtable('2021_07_30_11_50_04.csv');
t_n1 = readtable('2021_07_30_11_55_47.csv');
t_n2 = readtable('2021_07_30_12_02_05.csv');
t_r1 = readtable('2021_07_30_12_09_22.csv');
t_n3 = readtable('2021_07_30_12_14_37.csv');
t_n4 = readtable('2021_07_30_12_20_32.csv');
t_r2 = readtable('2021_07_30_12_26_07.csv');
t_tt = readtable('2021_07_30_12_32_02.csv');

%pilot 8
t_ba = readtable('2021_08_27_12_12_06.csv');
t_n1 = readtable('2021_08_27_12_16_35.csv');
t_n2 = readtable('2021_08_27_12_20_37.csv');
t_r1 = readtable('2021_08_27_12_25_31.csv');
t_n3 = readtable('2021_08_27_12_30_22.csv');
t_n4 = readtable('2021_08_27_12_34_28.csv');
t_r2 = readtable('2021_08_27_12_39_02.csv');
t_n5 = readtable('2021_08_27_12_43_10.csv');
t_n6 = readtable('2021_08_27_12_47_02.csv');
t_r3 = readtable('2021_08_27_12_51_25.csv');
t_tt = readtable('2021_08_27_12_55_56.csv');

t_dat = {t_ba, t_n1, t_n2, t_r1, t_n3, t_n4, t_r2, t_n5, t_n6, t_r3, t_tt};

%% Calculate finishing times
distance = 0.4; % required distance to be completed in each trial

k_arr = cell(1,length(t_dat));
time_dat = zeros(1,length(t_dat));

for d = 1: length(t_dat)
     k_arr{d} = t_dat{d}.km > distance; % all indices beyond the 400m distance
     time_dat(d) = min(t_dat{d}.secs(k_arr{d})); 
     % it may need to be a second shorter (but doesn't change relativeresutls)
end


%% Set color palette
cBA = [25 25 25]/255;
cN1 = [228 26 28]/255;
cN2 = [255 127 0]/255;
cN3 = [228 26 28]/255;
cR1 = [55 126 184]/255;
cR2 = [77 175 74]/255;
cR3 = [55 126 184]/255;
cTT = [152 78 163]/255;

c_dat = {cBA ,cN1 ,cN1 ,cR1, cN2, cN2, cR2, cN3, cN3, cR3, cTT};

%% Plot finishing times
fig1 = figure('color','w');

for d = 1:length(t_dat)

    scatter(d, time_dat(d), 80, c_dat{d}, 'filled')
    hold on
end


ax = gca;
% ax.Color = 'none';
% ax.XColor = 'w';
% ax.YColor = 'w';
ax.XTick = 0:11;
ax.XTickLabels = {'','Baseline','N1','N2','R1','N3','N4','R2', 'N5', 'N6', 'R3','TT',''};

maxTime = 60;

xlim([0 11])
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
% figure
for d = 1:length(t_dat)
   t_ax = t_dat{d}.secs(~k_arr{d});
   d_ax = t_dat{d}.km(~k_arr{d});
   
   first_nonzero_idx= find(d_ax>0,1,'first');
   
   plot(t_ax(1:end-first_nonzero_idx+1), d_ax(first_nonzero_idx:end)*1000,...
       'color',c_dat{d},'linewidth',w1);
   hold on
   xline(t_ax(end-first_nonzero_idx+1), ':','color',c_dat{d});
end 

hold off;


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
% keyboard

%% velocity
ax2 = subplot(412);
% figure

for d = 1:length(t_dat)
   t_ax = t_dat{d}.secs(~k_arr{d});
   v_ax = t_dat{d}.kph(~k_arr{d});
   
   first_nonzero_idx= find(t_dat{d}.km(~k_arr{d})>0,1,'first');
   
   plot(t_ax(1:end-first_nonzero_idx+1),...
       movmean(v_ax(first_nonzero_idx:end),[0,4]),...
       'color',c_dat{d},'linewidth',w1);
   hold on
end 

% ax2.Color = 'none';
% ax2.XColor = 'w';
% ax2.YColor = 'w';
% ax2.YTick = 0:2:12;

% xlim([0 maxTime])
% ylim([0 12])
box off
ylabel('Velocity (m s^{-1})')


%% power output
ax3 = subplot(413);
% figure,

for d = 1:length(t_dat)
   t_ax = t_dat{d}.secs(~k_arr{d});
   w_ax = t_dat{d}.watts(~k_arr{d});
   
   first_nonzero_idx= find(t_dat{d}.km(~k_arr{d})>0,1,'first');
   
   plot(t_ax(1:end-first_nonzero_idx+1),...
       movmean(w_ax(first_nonzero_idx:end),[0,4]),...
       'color',c_dat{d},'linewidth',w1);
   hold on
end 

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
% figure,

for d = 1:length(t_dat)
   t_ax = t_dat{d}.secs(~k_arr{d});
   c_ax = t_dat{d}.cad(~k_arr{d});
   
   first_nonzero_idx= find(t_dat{d}.km(~k_arr{d})>0,1,'first');
   
   plot(t_ax(1:end-first_nonzero_idx+1), c_ax(first_nonzero_idx:end),...
       'color',c_dat{d},'linewidth',w1);
   hold on
end 

% ax4.Color = 'none';
% ax4.XColor = 'w';
% ax4.YColor = 'w';
ax4.YTick = 0:20:120;

xlim([0 maxTime])
ylim([0 120])
box off
xlabel('Time (s)')
ylabel('Cadence (RPM)')
%% Modified finishing time (total time since distance first non-zero)
figure
for d = 1:length(t_dat)
    t_ax = t_dat{d}.secs(~k_arr{d});
    first_nonzero_idx= find(t_dat{d}.km(~k_arr{d})>0,1,'first');
    scatter(d, t_ax(end)-t_ax(first_nonzero_idx), 80, c_dat{d}, 'filled')
    hold on
end
ylabel('Modified finishing time');

%% Look at the derivative of velocity

figure

for d = 1:length(t_dat)
   t_ax = t_dat{d}.secs(~k_arr{d});
   a_ax = diff23f5(t_dat{d}.kph(~k_arr{d}),1,0.4);
   a_ax =a_ax(:,2);
   first_nonzero_idx= find(t_dat{d}.km(~k_arr{d})>0,1,'first'); % using first non-zero distance
   
   plot(t_ax(1:end-first_nonzero_idx+1),...
       movmean(a_ax(first_nonzero_idx:end),[0,4]),...
       'color',c_dat{d},'linewidth',w1);
   hold on
end 

xlim([0 maxTime])
% ylim([0 12])
box off
ylabel('Acceleration(m s^{-2})')



%% Plot average cadence
fig3 = figure('color','w');

for d = 1:length(t_dat)
    
    scatter(d, mean(t_dat{d}.cad(~k_arr{d})), 80, c_dat{d}, 'filled')
    hold on
end

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

for d = 1:length(t_dat)
    
    scatter(d, mean(t_dat{d}.watts(~k_arr{d})), 80, c_dat{d}, 'filled')
    hold on
end

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

trq_dat = cell(1,length(t_dat));
for d = 1:length(t_dat) 
    trq_dat{d} = mean(t_dat{d}.watts(~k_arr{d}))/ ...
        (mean(t_dat{d}.cad(~k_arr{d}))/ 60*2*pi);
end

for d = 1:length(t_dat)
    
    scatter(d, trq_dat{d}, 80, c_dat{d}, 'filled')
    hold on
end

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

%% Peak rate of ramp up
figure 
for d =1:length(t_dat)
    a_ax = diff23f5(t_dat{d}.kph(~k_arr{d}),1,0.4);
    a_ax = a_ax(:,2);
    scatter(d, max(a_ax), 80, c_dat{d}, 'filled')
    hold on
end

box off
xlabel('Trial Number')
ylabel('Peak Acceleration (m s^-2)')

%% Export figures
keyboard
cd(resDir)
export_fig(fig1,'fig_pilot07_finishingTimes','-png','-eps','-cmyk','-r600')
export_fig(fig2,'fig_pilot07_timeSeries','-png','-eps','-cmyk','-r600')
export_fig(fig3,'fig_pilot07_meanCadence','-png','-eps','-cmyk','-r600')
export_fig(fig4,'fig_pilot07_meanPower','-png','-eps','-cmyk','-r600')
export_fig(fig5,'fig_pilot07_meanTorque','-png','-eps','-cmyk','-r600')
