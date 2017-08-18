% This is a script to plot PSTH and selectivity of individual cell
% 
% cellId: determines which cell to plot
%
% Plot
% blue: lick right
% red: lick left


%% load data
cellId = 1; % cell to plot
load('ephysDataset.mat') % load data

%% Calculate the mean spike rate & selectivity
meanR = mean(ephysDataset(cellId).unit_yes_trial,1); % mean PSTH of lick R trial
meanL = mean(ephysDataset(cellId).unit_no_trial,1);  % mean PSTH of lick L trial
selectivity = meanR - meanL; % contra selectivity: difference in spike rate between two trial types (R - L)

%% plot the PSTH
figure
hold on
plot(timeTag,meanR,'b')
plot(timeTag,meanL,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ; % plot timing of each epoch
xlim([-3  1.5]); % range of X axis
xlabel('Time (s)')
ylabel('Spikes per s')
hold off
print('images/plot_PSTH','-dpng')

%% plot the contra selectivity
figure
hold on
plot(timeTag,selectivity,'k')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;  % plot timing of each epoch
xlim([-3  1.5]); % range of X axis
xlabel('Time (s)')
ylabel('Contra selectivity (Spikes per s)')
hold off

print('images/plot_contra_selectivity','-dpng')

