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

sessionId = 1;
sessionData = ephysDataset([ephysDataset.sessionIndex] == sessionId & [ephysDataset.cell_type]==1);
numUnit = length(sessionData);
numTime = length(timeTag);
cdMat = zeros(numUnit, numTime);

for cellId = 1:numUnit
    meanR = mean(ephysDataset(cellId).unit_yes_trial,1)/sampleRate;
    meanL = mean(ephysDataset(cellId).unit_no_trial,1)/sampleRate;
    cdMat(cellId, :) = meanR - meanL;
end

figure;
title(['Coding direction for Session #' num2str(sessionId)])
hold on
imagesc(timeTag, timeTag, corr(cdMat));
gridxy([-2.6 -1.3 0],[-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
ylim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Time from movement (sec)')
hold off


