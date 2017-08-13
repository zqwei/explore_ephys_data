% This is a scrupt to plot PSTH and selectivity of individual cell
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
selectivity = meanR - meanL; % selectivity: difference in spike rate between trial type

%% plot the PSTH
figure
hold on
plot(timeTag,meanR,'b')
plot(timeTag,meanL,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.1  2]);
xlabel('Time (s)')
ylabel('Spikes per s')
hold off

%% plot the selectivity
figure
hold on
plot(timeTag,selectivity,'k')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.1  2]);
xlabel('Time (s)')
ylabel('Selectivity (Spikes per s)')
hold off

