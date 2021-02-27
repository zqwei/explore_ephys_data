function [ PSTH ] = func_plot_PSTH (cellId,timeTag,ephysDataset)
% Plot PSTH of individual cell
%
% This code will plot PSTH of individual cell.
%
% Input
% cellId  : ID of neuron
% timeTag : time axis
% ephysDataset: ephys data
%
% Plot
% blue: lick right
% red: lick left
%
% Output
% PSTH: PSTH of lick R trials (1st row) and lick L trials  (2nd row)

    %% Calculate the mean spike rate
    meanR = mean(ephysDataset(cellId).sr_right,1);
    meanL = mean(ephysDataset(cellId).sr_left,1);
    PSTH  = [meanR;meanL];

    %% plot the PSTH
    figure
    hold on
    plot(timeTag,meanR,'b')
    plot(timeTag,meanL,'r')
    gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
    xlim([-3.1  2]);
    xlabel('Time (s)')
    ylabel('Spikes per s')
    hold off


end

