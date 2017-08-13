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
xlim([-3.1  2]);
xlabel('Time from movement (sec)')
ylabel('Fano factor')
hold off
