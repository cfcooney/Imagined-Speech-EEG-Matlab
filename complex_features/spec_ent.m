function spectral_entropy = spec_ent(window,fs)
% Function for computing Spectral Entropy from EEG signal
%     
%     INPUTS
%     window = time-series EEG data-frame
%     fs = sampling frequency
%
%     OUTPUTS
%     spec_ent = Spectral Entropy of input time-series
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018

if nargin < 2, fs = 1000;      end
N = length(window);
freq_bands = [1,50];
f_scale=(N/fs);
ind = floor(N/2+1);

wdfft = fft(window);
wdfft = wdfft(1:ind);

psd = (1/(fs*N)) * abs(wdfft).^2;
N_psd = psd./sum(psd);

spectral_entropy = -sum(N_psd.*(log2(N_psd))/log2(length(N_psd)));

