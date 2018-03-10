%Name: Ciaran Cooney
%Date: 10/03/2018
%Script for iterating through subject folders and returning mel frequency
%ceptral coefficients in vectorised format.

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

n_chan = 62;
for j=1:length(folders)
    
    disp(['Computing MFCC for participant ' folders{j}]);
    folder = [data_path '/' folders{j}];
    data = load([folder '/' 'EEG_Data.mat']); 
    trials = data.EEG_Data.EEG;
    trial_mfcc = {};
    trial_vec = {};
    n_coeff = 13;
    for k=1:length(trials)
        trial = trials{k};
        mf_vec = [];
            for m=1:n_chan
                chan = trial(m,1:end);
                mf = cepstra_coeffs(chan); %
                for i = 1:n_coeff
                    vec = mf(i,1:end);
                    mf_vec = cat(2,mf_vec,vec);
                end
                mfcc{m} = mf;
                m = m+1;
            end
            
        trial_mfcc{k} = mfcc;
        trial_vec{k} = mf_vec;
    end
    subject_mfcc = trial_mfcc;
    output_folder = [folder '\' 'features'];
    disp(['Saving MFCC for participant ', folders{j}]);
    save([output_folder '/MFCC.mat'], 'subject_mfcc');
    save([output_folder '/mfcc_vec.mat'], 'trial_vec');
    j = j+1;
end