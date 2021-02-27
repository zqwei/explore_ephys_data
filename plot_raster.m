% plot rasters 
% 
% This code will go through raster plot for a selected single neuron at
% for each behavioral conditions.
%
% blue: lick right
% red: lick left
% 
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

% cell number (ranged from 1 to length of datasets)
cellId = 1;

st_right = ephysDataset(cellId).st_right;

figure;

title(['Raster plot for cell #' num2str(cellId)]);

hold on;

numTrial = 0;

for ntrial = 1:length(st_right)
    spkTime = st_right{ntrial};
    numTrial = numTrial + 1;
    plot(spkTime, numTrial * ones(length(spkTime), 1), '.b');
end

st_left = ephysDataset(cellId).st_left;

for ntrial = 1:length(st_left)
    spkTime = st_left{ntrial};
    numTrial = numTrial + 1;
    plot(spkTime, numTrial * ones(length(spkTime), 1), '.r');
end

gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
hold on
xlim([-3.0  1.5]);
ylim([0.5 numTrial+0.5]);
xlabel('Time from movement (sec)')
ylabel('Trial index')
