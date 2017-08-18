% plot dpca
% 
% This code will go through dpca plot for a selected single
% session for two behavioral conditions.
%
% You need download function named:
% 1. dpca
% 2. dpca_explainedVariance
% 
% from
% https://github.com/machenslab/dPCA/tree/master/matlab
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

sessionId = 1;
sessionData = ephysDataset([ephysDataset.sessionIndex] == sessionId & [ephysDataset.cell_type]==1);
numUnit = length(sessionData);
numTime = length(timeTag);

meanMatR = zeros(numUnit, numTime);
meanMatL = zeros(numUnit, numTime);

for cellId = 1:numUnit
    meanR = mean(ephysDataset(cellId).unit_yes_trial,1);
    meanL = mean(ephysDataset(cellId).unit_no_trial,1);
    meanMatR(cellId, :) = meanR;
    meanMatL(cellId, :) = meanL;
end

% structure of analyzed params
combinedParams = {{1}, {2}, {[1 2]}};
margNames      = {'Stim', 'Time', 'Inter'};

% firingRatesAverage --- #neuron x nStim x T (nStim = 2: left and right lick)
firingRatesAverage = zeros(numUnit, 2, numTime);
firingRatesAverage(:, 1, :) = meanMatR;
firingRatesAverage(:, 2, :) = meanMatL;

% number of dpca component
numComps = 5;

[W,V,whichMarg] = dpca(firingRatesAverage, numComps, ...
            'combinedParams', combinedParams);
explVar = dpca_explainedVariance(firingRatesAverage, W, V, 'combinedParams', combinedParams);

figure
bar(1:numComps, explVar.margVar(:, 1:numComps)', 'stack', 'edgecolor', 'none');
box off
legend(margNames)
xlim([0 numComps+1])
ylim([0 100])
xlabel('Component index')
set(gca,'xTick', 0:numComps)
ylabel('% EV per PC')
save(