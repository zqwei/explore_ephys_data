% plot coding direction
% 
% This code will go through coding direction plot for a selected single
% session for two behavioral conditions.
%
% 
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

sessionId = 1;
sessionData = ephysDataset([ephysDataset.sessionIndex] == sessionId & [ephysDataset.cell_type]==1);
numUnit = length(sessionData);
numTime = length(timeTag);


%% coding direction

cdMat    = zeros(numUnit, numTime);
meanMatR = zeros(numUnit, numTime);
meanMatL = zeros(numUnit, numTime);

for cellId = 1:numUnit
    meanR = mean(ephysDataset(cellId).unit_yes_trial,1);
    meanL = mean(ephysDataset(cellId).unit_no_trial,1);
    cdMat(cellId, :) = meanR - meanL;
    meanMatR(cellId, :) = meanR;
    meanMatL(cellId, :) = meanL;
end

figure;
title(['Coding direction correlation across time for Session #' num2str(sessionId)])
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
title(['Coding direction projection for Session #' num2str(sessionId)])
hold on
plot(timeTag, popR, '-b')
plot(timeTag, popL, '-r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Activity projected coding direction')
hold off

