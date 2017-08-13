% plot fano factor 
% 
% This code will go through coding direction plot for a selected single
% session for two behavioral conditions.
%
% 
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

sessionData = simDataset;
numUnit = length(sessionData.nUnit);
numTime = length(timeTag);

%% coding direction
meanMatR = squeeze(mean(sessionData.unit_yes_trial));
meanMatL = squeeze(mean(sessionData.unit_no_trial));
cdMat    = meanMatR - meanMatL;

figure;
title('Coding direction correlation across time for Simultaneous Session')
hold on
imagesc(timeTag, timeTag, corr(cdMat));
gridxy([-2.6 -1.3 0],[-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
ylim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Time from movement (sec)')
hold off


%% projection of data to delay-epoch coding direction 
cdDelay = mean(cdMat(:, timeTag > -1.3 & timeTag < 0), 2);
cdDelay = cdDelay/norm(cdDelay);
popR    = meanMatR' * cdDelay;
popL    = meanMatL' * cdDelay;

figure;
title('Coding direction projection for Simultaneous Session')
hold on
plot(timeTag, popR, '-b')
plot(timeTag, popL, '-r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Activity projected coding direction')
hold off

