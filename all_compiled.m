%
% A compilation of analysis scripts for the 2017 JHU in bootcamp
%
%
% 

%% Cell-based analyses

%%
% 1. Plot rasters
%   each spike is a dot
%   trials are arrayed in the vertical dimension, time in the horizontal dimension

plot_raster

%%
% 2. Estimate mean spike rate for each trial type as sr(R), sr(L)
% 3. Plot mean spike rate for different trial types
% 4. Compute selectivity as sr(R) - sr(L)
plot_PSTH_with_selectivity

%% 
% 4.1 Fano factors. The Fano factor (FF) is a measure of the variability of
% the spike count across trials. The change in FF across time in a trial is
% related to certain model predictions
plot_ff

% If you have time compute FF for different bins (have to go to the spike
% data)

%%
% 5. Error trial
% Change the name of variable in each function and explore the error trials

%% Session-based analysis

%%
% 6. Grand average (average across trials and neurons) ...
% 7. Grand average selectivity and its absolute value
plot_session_PSTH_with_selectivity


%% Dimensionality reduction

%%
% 8. Compute the coding direction (CD) and direction with max variance orthognal to the coding direction

plot_CD_sim

%%
% 9. dPCA is another dimensionality reduction method with different
% properties.
% optional

plot_dpca