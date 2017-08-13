# explore ephys data
This is repo for the hand-on lecture on 08/21.

## Dataset Description
### Task description:
* Tactile delayed response task
* A pole is presented to whiskers of an animal during a "sample epoch". The location of pole instructs the animal which direction to lick (left or right).
* The sample epoch was followed by a "delay epoch", while the animal was trained not to move.
* At the beginning of a "response poch", a brief "go cue" (100ms)instructs the animal to move.


### Task structure:
* Pre-sample: -3.1 to -2.6 sec.
* Sample: -2.6 to -1.3 sec.
* Delay: -1.3 to 0 sec.
* Response: 0 - 2 sec.

### Data structure:
* sessionIndex : index of the session which neuron is recorded. Each session is recorded by JRC multi-electrode arrays (64 channels).
* nUnit: index of the neuron(unit) in each recording session.
* unit_yes_trial: correct right-lick trial (contra-laterial behavior trial) where spike count is binned by 67 ms discretely in time.
* unit_no_trial: correct left-lick trial (ipsi-laterial behavior trial) where spike count is binned by 67 ms discretely in time.
* unit_yes_trial_index: trial index for each correct right-lick trial.
* unit_no_trial_index: trial index for each correct left-lick trial.
* unit_yes_trial_spk_time: spike times for each neuron/unit in a correct right-lick trial (unit in sec).
* unit_no_trial_spk_time: spike times for each neuron/unit in a correct left-lick trial (unit in sec).
* unit_yes_error: error right-lick trial (contra-laterial behavior trial) where spike count is binned by 67 ms discretely in time.
* unit_no_error: error left-lick trial (ipsi-laterial behavior trial) where spike count is binned by 67 ms discretely in time.
* unit_yes_error_index: trial index for each error right-lick trial.
* unit_no_error_index: trial index for each error left-lick trial.
* unit_yes_error_spk_time: spike times for each neuron/unit in an error right-lick trial (unit in sec).
* unit_no_error_spk_time: spike times for each neuron/unit in an error left-lick trial (unit in sec).
* depth_in_um: recording depth of the unit in um.
* cell_type: putative pyramidal cells -- 1; fast-spiking interneurons: 0.


## Cell-based analyses
### Plot rasters
* each spike a dot
* trials arrayed in the vertical dimension, time in the horizontal dimension
### Estimate mean spike rate (try different averaging windows)
### Plot mean spike rate for different trial types
* Extra - test for stationarity of sr across time in the session
### Compute selectivity as sr(R) - sr(L); do statistical test (bootstrapping or ranksum)
* Extra - Fano Factors
* Extra - does Fano Factor increase or decrease during the delay epoch? Compare Sample epoch, Early Delay and Late Delay
### Error trial analysis — is activity similar or different?


## Session-based analysis (i.e. across neurons recorded simultaneously in a session)
### Grand average --  spike rate (__sr__)
### Grand average, sr(L), sr(R) - correct trials only
### Grand average, abs(sr(R) - sr(L))


## Dimensionality reduction
### Find the coding direction - CD; this is the direction in activity space where trial types can best be discriminated
* We will use the simplest definition:

sr_i(R)-sr_i(L)

where i is the cell index; then normalize to produce a unit vector
* Do SVD; use Gram-Schmitt procedure to rotate the space to be orthogonal to CD
* Extra dPCA — download code from Machens website
