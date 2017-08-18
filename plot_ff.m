% plot fano factor 
% 
% This code will go through fano factor plot for a selected single neuron at
% for each behavioral conditions.
%
% blue: lick right
% red: lick left
% 
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

sampleRate = 14.84;
cellId = 1;

% fano factor is computed as the variance of spike counts across trial over 
% its mean across trial

% one would transfer the spike rate in our dataset to spike count by sample
% rate
meanR = mean(ephysDataset(cellId).unit_yes_trial,1)/sampleRate;
meanL = mean(ephysDataset(cellId).unit_no_trial,1)/sampleRate;
varR  = var(ephysDataset(cellId).unit_yes_trial,1)/sampleRate^2;
varL  = var(ephysDataset(cellId).unit_no_trial,1)/sampleRate^2;
FF_R  = varR./meanR;
FF_L  = varL./meanL;

figure
hold on
plot(timeTag, FF_R,'b')
plot(timeTag, FF_L,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Fano factor')
hold off
print('images/plot_ff','-dpng')