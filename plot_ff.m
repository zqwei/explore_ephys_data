% Compute a plot fano factor as a function of time. Use the binned data
% in unit_yes_trial etc. The FF is variance over mean for some time bin
% (here 
% 
% This code will compute the fano factor for a selected single neuron and 
% for each behavioral condition.
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

% Fano factor is computed as the variance of spike counts across trial over 
% its mean across trial

% Divide spike rate by sample rate to get spike count;
% Divide variance of spike rate by sample rate squared to get variance of spike count 
meanR = mean(ephysDataset(cellId).sr_right,1)/sampleRate;
meanL = mean(ephysDataset(cellId).sr_left,1)/sampleRate;
varR  = var(ephysDataset(cellId).sr_right,1)/sampleRate^2;
varL  = var(ephysDataset(cellId).sr_left,1)/sampleRate^2;
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
