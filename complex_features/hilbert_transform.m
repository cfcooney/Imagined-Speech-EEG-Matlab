function [magnitude,phase] = hilbert_transform(x,fs)
% Function for computing frequency oscillation phase and magnitude from
% EEG data using the Hilbert Transform    
%     INPUTS
%     x = time-series EEG data-frame
%     fs = sampling frequency
%     
%     OUTPUTS
%     magnitude = computed as absolute value of transformed signal
%     phase = phase angle of transformed signal
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018
if nargin < s;    fs = 1000;               end

z = hilbert(x);
magnitude = abs(z);
phase = unwrap(angle(z));