%Name: Ciaran Cooney
%Date: 26/02/2018
%Script for computing Higuchi Fractal Dimension. Adapted from scripts
%written by John M. O' Toole, University College Cork @:
%https://github.com/otoolej/qEEG_feature_set

%[1] JM O’Toole and GB Boylan (2017). NEURAL: quantitative features for newborn EEG using Matlab.

function FD = fractal_dimension(x,Fs,params_st)

%% Parameters can be set insider or outide function
if nargin < 3,  FREQ_BANDS = [1 50];
                param_st.method='higuchi'; 
                param_st.freq_bands=[FREQ_BANDS(1) FREQ_BANDS(end)];
                param_st.kmax=6; 
                param_st.FILTER_REPLACE_ARTEFACTS='cubic_interp';
end

DBplot=0;

freq_bands=params_st.freq_bands;
N_freq_bands=size(freq_bands,1);

if(isempty(freq_bands))
    N_freq_bands=1;
end

x_orig=x;

for n=1:N_freq_bands
    if(~isempty(freq_bands))
        x=filter_butterworth_withnans(x_orig,Fs,freq_bands(n,2),freq_bands(n,1),5, ...
                                      params_st.FILTER_REPLACE_ARTEFACTS);
    end
N=length(x);

DBplot=0;
kmax = params_st.kmax;

if(nargin<2 || isempty(kmax)), kmax=floor(N/10); end

FD=[]; L=[];

ik=1; k_all=[]; knew=0;
while( knew<kmax )
    if(ik<=4)
        knew=ik;
    else
        knew=floor(2^((ik+5)/4));
    end
    if(knew<=kmax)
        k_all=[k_all knew];
    end
    ik=ik+1;
end

%---------------------------------------------------------------------
% curve length for each vector:
%---------------------------------------------------------------------
inext=1; L_avg=zeros(1,length(k_all));
for k=k_all
    
    L=zeros(1,k);
    for m=1:k
        ik=1:floor( (N-m)/k );
        scale_factor=(N-1)/(floor( (N-m)/k )*k);
        
        L(m)=sum( abs( x(m+ik.*k) - x(m+(ik-1).*k) ) )*(scale_factor/k);
    end

    L_avg(inext)=mean(L);
    inext=inext+1;    
end

x1=log2(k_all); y1=log2(L_avg);
c=polyfit(x1,y1,1);
FD=-c(1);

end