oldFields = {'unit_yes_trial', 'unit_no_trial', 'unit_yes_trial_index', 'unit_no_trial_index', ...
             'unit_yes_trial_spk_time', 'unit_no_trial_spk_time', 'unit_yes_error', 'unit_no_error', ...
             'unit_yes_error_index', 'unit_no_error_index', 'unit_yes_error_spk_time', 'unit_no_error_spk_time'};
newFields = {'sr_right', 'sr_left', 'right_trial_index', 'left_trial_index', ...
             'st_right', 'st_left', 'sr_right_error', 'sr_left_error', ...
             'right_trial_error_index', 'left_trial_error_index', 'st_right_error', 'st_left_error'};

for nField = 1:length(oldFields)
    oldField = oldFields{nField};
    newField = newFields{nField};
    [ephysDataset.(newField)] = ephysDataset.(oldField);
    ephysDataset = rmfield(ephysDataset,oldField);
end


oldFields = {'unit_yes_trial', 'unit_no_trial', 'unit_yes_trial_index', 'unit_no_trial_index'};
newFields = {'sr_right', 'sr_left', 'right_trial_index', 'left_trial_index'};

for nField = 1:length(oldFields)
    oldField = oldFields{nField};
    newField = newFields{nField};
    [simDataset.(newField)] = simDataset.(oldField);
    simDataset = rmfield(simDataset,oldField);
end

save('ephysDataset.mat', 'ephysDataset', 'simDataset', 'timeTag');