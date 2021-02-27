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

% coding direction is defined as a vector spanned by neurons;
% each element is the difference of the mean activity of neurons in two
% trial type conditions.

cdMat    = zeros(numUnit, numTime);
meanMatR = zeros(numUnit, numTime);
meanMatL = zeros(numUnit, numTime);

for cellId = 1:numUnit
    meanR = mean(ephysDataset(cellId).sr_right,1);
    meanL = mean(ephysDataset(cellId).sr_left,1);
    cdMat(cellId, :) = meanR - meanL;
    meanMatR(cellId, :) = meanR;
    meanMatL(cellId, :) = meanL;
end

% We now explore the similarity of coding direction across time using corr
% function in matlab.
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

% delay-epoch coding direction is defined as an average of coding direction
% over whole delay period -1.3 to 0 sec in time tag.

cdDelay = mean(cdMat(:, timeTag > -1.3 & timeTag < 0), 2);
cdDelay = cdDelay/norm(cdDelay);
popR    = meanMatR' * cdDelay;
popL    = meanMatL' * cdDelay;

% We now project the neuronal activity in different trial type conditions
% to the coding direction.

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

