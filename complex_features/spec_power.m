function spectral_power = spec_power(x,Fs,param_st)
% Function for computing Spectral Power from EEG signal
%     
%     INPUTS
%     window = time-series EEG data-frame
%     fs = sampling frequency
%
%     OUTPUTS
%     spec_ent = sum of the spectral power using periodogram.
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018
if(nargin<2), Fs = 1000; end
if(nargin<3), param_st.method = 'periodogram';
              param_st.freq_bands = [1 50];
              param_st.total_freq_bands = [1 50];
              param_st.L_window = 0.5;
              param_st.window_type = 'hamm';
              param_st.overlap = 50; 
end
N = length(x);
pxx = gen_spectrum(x,Fs,param_st,1);
pxx = pxx.*Fs;

spec= sum(pxx/N);
spectral_power = sum(spec);


