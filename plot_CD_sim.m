% 
% This code will compute the coding direction for a selected session and 
% plot the projection to the coding direction .
%
% 
%
% Ziqiang Wei
% weiz@janelia.hhmi.org

load('ephysDataset.mat')

% use simDataset for the analysis
% unit_yes_trial : Spike rate of lick R trials in [trial, neuron, tim bin] format
% unit_no_trial  : Spike rate of lick R trials in [trial, neuron, tim bin] format

numUnit = size(simDataset.unit_yes_trial,2); % number of unit
numTime = length(timeTag); % number of time bin

%% coding direction
meanMatR = squeeze(mean(simDataset.unit_yes_trial,1)); 
% mean spike rate of each neuron at each time bin. Mean was caluclated over
% trials. Then squeezed to be 2 dimensional.
meanMatL = squeeze(mean(simDataset.unit_no_trial,1));
cdMat    = meanMatR - meanMatL; % note: this is the simplest way of computing the CD, but it has 
                                % some issues

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
timeToAnalyze =  timeTag > -0.4 & timeTag < 0; 
cdDelay = mean(cdMat(:,timeToAnalyze), 2); % avergae CD duirng the last 400ms of the delay epoch
cdDelay = cdDelay/norm(cdDelay); % normlize CD to be unit vector
cdProjR    = meanMatR' * cdDelay;  % projecton of lickR trial activity to CD
cdProjL    = meanMatL' * cdDelay;

figure;
title('Coding direction projection for Simultaneous Session')
hold on
plot(timeTag, cdProjR, '-b')
plot(timeTag, cdProjL, '-r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Activity projected coding direction')
hold off


%% find the second biggest mode

% acquire spike rate at pre sample peoch to subtract baseline spike rate
sample_start = -2.6;
preR = mean(simDataset.unit_yes_trial(:,:,timeTag<sample_start),3);  
preL = mean(simDataset.unit_no_trial(:,:,timeTag<sample_start),3);   
baseline_matrix = [preR;preL];
rdMat = nan(numUnit,numTime);

% Do SVD at each time point
for t = 1:numTime
    data = [ squeeze(simDataset.unit_yes_trial(:,:,t)); squeeze(simDataset.unit_no_trial(:,:,t))]; % spike rate at each time point
    data = data-baseline_matrix;
    [~,~,svd_v] = svd(data); % svd of spike rate 
    rdMat(:,t)=svd_v(:,1);   % extarct the first component
end

% average it and rotate to CD
rdDelay = mean(rdMat(:, timeToAnalyze), 2); % average SVD mode during the last 400ms of the delay epoch
[orth_Delay,along] = func_orthrog_vectors(cdDelay,rdDelay); % rotatet the mode to CD
orth_Delay = orth_Delay/norm(orth_Delay); % normalize it

%% projection of data to remainant direction
odProjR    = meanMatR' * orth_Delay;
odProjL    = meanMatL' * orth_Delay;

figure;
title('Remainant direction projection for Simultaneous Session')
hold on
plot(timeTag, odProjR, '-b')
plot(timeTag, odProjL, '-r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Activity projected orthogonal direction')
hold off   
            
            
%% variance explained

% first calucalte the square sum of spike rate among all neurons
srR = squeeze(mean(simDataset.unit_yes_trial,1));  
srL = squeeze(mean(simDataset.unit_no_trial,1)); 

varR   = sum(srR.^2,1);
varL   = sum(srL.^2,1);

% square of projection to CD
varCdR   = cdProjR'.^2;
varCdL   = cdProjL'.^2;

% square of projection to orthogonal direction
varOdR   = odProjR'.^2;
varOdL   = odProjL'.^2;

figure
subplot(2,1,1)
hold on
plot(timeTag, varCdR./varR,'b')
plot(timeTag, varCdL./varL,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Variance explained by coding direction')
subplot(2,1,2)
hold on
plot(timeTag, varOdR./varR,'b')
plot(timeTag, varOdL./varL,'r')
gridxy([-2.6 -1.3 0],'Color','k','Linestyle','--') ;
xlim([-3.0  1.5]);
xlabel('Time from movement (sec)')
ylabel('Variance explained by orthogonal direction')






            
