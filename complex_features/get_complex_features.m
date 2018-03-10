%Name: Ciaran Cooney
%Date: 10/03/2018
%Script for iteratring through subject data and computing complex features
%including hurst exponent and fractal dimension

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

n_chan = 62;
for i=1:length(folders)
    
    disp(['Computing complex features for participant ' folders{i}]);
    folder = [data_path '/' folders{i}];
    data = load([folder '/' 'window_data.mat']); 
    trials = data.all_trials;
    trial_hexp; trial_ph; trial_spec  = {}; %reset so length is not carried over
    trial_sp_pw; trial_mag; trial_ph = {};
    
    for j=1:length(trials)
        trial = trials{j};
        
        for k=1:length(trial)
            window = trial{k};
            
            for m=1:n_chan
                chan = window(m,1:end);
                h = genhurst(chan);
                hexp{m} = h;
                fd = fractal_dimension(chan,1000,param_st); 
                fdim{m} = fd;
                sp = spec_ent(chan); 
                spec{m} = sp;
                sp_pw = spec_power(chan,1000);
                spec_pw{m} = sp_pw;[magnitude,phase] = hilbert_transform(chan,1000); 
                mag{m} = mean(magnitude);
                ph{m} = mean(phase);
                m = m+1;
            end
            window_hexp{k} = hexp;
            window_fd{k} = fdim;
            window_spec{k} = spec;
            window_spec_pw{k} = spec_pw;
            window_mag = [window_mag,cell2mat(mag')];
            window_ph = [window_ph,cell2mat(ph')];
            k = k+1;
        end
        trial_hexp{j} = window_hexp;
        trial_fd{j} = window_fd;
        trial_spec{j} = window_spec;
        trial_sp_pw{j} = window_spec_pw;
        trial_mag{j} = window_mag;
        trial_ph{j} = window_ph;
        j= j+1;
    end
    output_folder = [folder '\' 'features'];
    disp(['Saving complex_features for participant ', folders{i}]);
    save([output_folder '/hurst_exp.mat'], 'trial_hexp');
    save([output_folder '/fractal_dimension.mat'], 'trial_fd');
    save([output_folder '/spectral_entropy.mat'], 'trial_spec');
    save([output_folder '/spectral_power.mat'], 'trial_sp_pw');
    save([output_folder '/magnitude.mat'], 'trial_mag');
    save([output_folder '/phase.mat'], 'trial_ph');
    i = i+1;
end