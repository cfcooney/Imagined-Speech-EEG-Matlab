%Name: Ciaran Cooney
%Date: 20/02/2018
% Bespoke function developed from mfcc scripts available @: 
% https://labrosa.ee.columbia.edu/matlab/rastamat/

function cepstra = cepstra_coeffs(d)
% Function for computing mel frequency cepstral coefficients developed
%from mfcc scripts available @: 
% https://labrosa.ee.columbia.edu/matlab/rastamat/
%     
%     INPUTS
%     window = time-series EEG data-frame
%
%     OUTPUTS
%     spec_ent = 13 mfcc coefficients
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018

if length(d) < 5000
    d = padding(d,5000);
else if length(d) > 5000
        d = d(1:5000);
    end
end
winpts = round(0.5*1000);
steppts = round(0.25*1000);

NFFT = 2^(ceil(log(winpts)/log(2)));
WINDOW = [hanning(winpts)'];
NOVERLAP = winpts - steppts;
SAMPRATE = 1000;

pspectrum = abs(specgram(d*32768,NFFT,SAMPRATE,WINDOW,NOVERLAP)).^2;

[nfreqs,nframes] = size(pspectrum);
nfft = (nfreqs-1)*2;
nfilts = ceil(hz2mel(1000/2))+1; %replaces hz2bark
wts = fft2melmx(nfft, 1000, nfilts, 1.0, 0, 500);
wts = wts(:, 1:nfreqs);

aspectrum = wts * pspectrum;

cepstra = spec2cep(aspectrum, 13);