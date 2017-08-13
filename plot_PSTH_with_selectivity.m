% This is a script to plot PSTH and selectivity of individual cell
%
% Input
% cellId  : ID of neuron to plot
%
% Plot
% blue: lick right
% red: lick left


%% load data
cellId = 1;
load('ephysDataset.mat')

%% Calculate the mean spike rate
meanR = mean(ephysDataset(cellId).unit_yes_trial,1); % mean PSTH of lick R trial
meanL = mean(ephysDataset(cellId).unit_no_trial,1);  % mean PSTH of lick L trial
selectivity = meanR - meanL; % contra selectivity: difference in spike rate between two trial types (R - L)

%% plot the PSTH
figure
hold on
plot(timeTag,meanR,'b')
plot(timeTag,meanL,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3  1.5]);
xlabel('Time (s)')
ylabel('Spikes per s')
hold off

%% plot the contra selectivity
figure
hold on
plot(timeTag,selectivity,'k')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3  1.5]);
xlabel('Time (s)')
ylabel('Contra selectivity (Spikes per s)')
hold off

