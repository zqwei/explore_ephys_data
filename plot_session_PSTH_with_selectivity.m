% This script plots the grand average PSTH and selectivity (across units
% and trials wtihin one session)
% We exclude fast spiking cells for this analysis
% ephysDataset.cell_type: cell type. 1 is regular spiking cell, 0 is fast
% spiking cell
%
% Plot
% blue: lick right
% red: lick left


%% load data
sessionId = 1; % ID of session to plot
load('ephysDataset.mat') % laod data


%% find the regular spiking units from the session
% sessionIndex should be the assigned sessionId & cell_type needs to be 1 (regular spiking cell)
sessionData = ephysDataset([ephysDataset.sessionIndex]==sessionId & [ephysDataset.cell_type]==1);
numUnit     = length(sessionData); % number of units
numTime     = length(timeTag);     % number of time bins


%% Calculate the mean spike rate of each unit
% predefine matrix of nan's (i.e. 'not a number')_
meanR = nan(numUnit, numTime);
meanL = nan(numUnit, numTime);
selectivity = nan(numUnit, numTime);

% run a loop to extract data from each unit
for cellID = 1:numUnit

    % calcualte mean PSTH of each unit
    meanR(cellID,:) = mean(sessionData(cellID).sr_right,1);
    meanL(cellID,:) = mean(sessionData(cellID).sr_left,1);    
    
    % calculate selectivity of each cell
    % Only cells with siginificant selectivity during the delay epoch is included 
    % negative selectivity during the delay epoch is flipped to be positive 
        
    % extarct spike rate during the delay epoch
    delayTimbin = timeTag>-1.3 & timeTag<0; % timbin of delay epoch
    srDelayR    = mean(sessionData(cellID).sr_right(:,delayTimbin),2); % spike rate during delay lick R trial
    srDelayL    = mean(sessionData(cellID).sr_left(:,delayTimbin),2);  % spike rate during delay lick L trial
    
    % ranksum test to check if spike rates are significantly different between two trial types
    p = ranksum(srDelayR,srDelayL);
    
    % if spike rates are significantly different calcualte selectivity
    % reverse the direction if slectivity is negative
    % non selective trials are kept as nan
    if     p < 0.05 && mean(srDelayR) > mean(srDelayL)
        
        selectivity(cellID,:) = meanR(cellID,:) - meanL(cellID,:);
        
    elseif p < 0.05 && mean(srDelayR) < mean(srDelayL)
        
        selectivity(cellID,:) = meanL(cellID,:) - meanR(cellID,:); 
        
    end
  
end


%% plot the PSTH
figure
hold on
plot(timeTag,mean(meanR),'b') % mean spike rate among cells
plot(timeTag,mean(meanL),'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3  1.5]);
xlabel('Time (s)')
ylabel('Spikes per s')
hold off

%% plot the selectivity
figure
hold on
plot(timeTag,nanmean(selectivity),'k') % mean selectivty  among cells
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3  1.5]);
xlabel('Time (s)')
ylabel('Selectivity (Spikes per s)')
hold off
