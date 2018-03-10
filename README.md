# Imagined-Speech-EEG-Matlab
Data extraction and processing of EEG trials corresponding to imagined speech. The dataset has been acquired from: http://www.cs.toronto.edu/~complingweb/data/karaOne/karaOne.html

'spit_data_cc.m' and 'windowing.m' or 'zero_pad_windows' will extract the EEG Data from the Kara One dataset only corresponding to imagined speech trials and window the data. Default setting is to segment data in to 500ms frames with 250ms overlap but this can easily be changed in the code.
