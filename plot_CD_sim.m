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

print('images/plot_coding_direction_correlation','-dpng')
%% projection of data to delay-epoch coding direction 
timeToAnalyze =  timeTag > -0.4 & timeTag < 0;
cdDelay = mean(cdMat(:,timeToAnalyze), 2);
cdDelay = cdDelay/norm(cdDelay);
cdProjR    = meanMatR' * cdDelay;
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

print('images/plot_neural_activity_project_to_coding_direction','-dpng')
%% find the second biggest mode
sample_start = -2.6;
preR = mean(sessionData.unit_yes_trial(:,:,timeTag<sample_start),3);  
preL = mean(sessionData.unit_no_trial(:,:,timeTag<sample_start),3);   
baseline_matrix = [preR;preL];
rdMat = nan(numUnit,numTime);

% number of mode
n = 1;

for t = 1:numTime
    data = [ squeeze(sessionData.unit_yes_trial(:,:,t)); squeeze(sessionData.unit_no_trial(:,:,t))];
    data = data-baseline_matrix;
    [~,~,svd_v] = svd(data); % svd of R & L
    rdMat(:,t)=svd_v(:,n);
end

% average it and rotate to CD
rdDelay = mean(rdMat(:, timeToAnalyze), 2);
[orth_Delay,along] = func_orthrog_vectors(cdDelay,rdDelay);
orth_Delay = orth_Delay/norm(orth_Delay);

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
% SR 
srR = squeeze(mean(sessionData.unit_yes_trial,1));  
srL = squeeze(mean(sessionData.unit_no_trial,1)); 

varR   = sum(srR.^2,1);
varL   = sum(srL.^2,1);

varCdR   = cdProjR'.^2;
varCdL   = cdProjL'.^2;

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

print('images/plot_neural_activity_project_to_other_direction','-dpng')





            
