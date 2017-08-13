function [ PSTH ] = func_plot_PSTH (cellId,timeTag,ephysDataset)
% Plot PSTH of individual cell
% 
% Input
% timeTag : time axis
% cellId  : ID of neuron
%
% Output
% PSTH: PSTH of lick R trials (1st row) and lick L trials  (2nd row)

    %% Calculate the mean spike rate
    meanR = mean(ephysDataset(cellId).unit_yes_trial,1);
    meanL = mean(ephysDataset(cellId).unit_no_trial,1);
    PSTH  = [meanR;meanL];

    %% plot the PSTH
    figure
    hold on
    plot(timeTag,meanR,'b')
    plot(timeTag,meanL,'r')
    xlabel('Time (s)')
    ylabel('Spikes per s')
    hold off


end

