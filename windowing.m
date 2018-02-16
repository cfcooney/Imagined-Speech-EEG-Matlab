% Name: Ciaran Cooney
% Date: 01/02/2018
% Script for windowing EEG data into segments for feature extraction.
% Data extracted from imagined speech trials only @
% "http://www.cs.toronto.edu/~complingweb/data/karaOne/karaOne.html"

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}]; 

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

for f=1:length(folders)
    disp(['Working on folder ', folders{f}]);
    folder = [data_path '/' folders{f}];
    file = [folder '/' 'EEG_Data'];
    load(file);
    Data = EEG_Data.EEG; 

    samples = 5000; %expected samples per trial
    window_size = .1; 
    window_samples = samples*window_size; %expected samples per window
    window_ratio = samples/window_samples;
    n_windows = window_ratio*2 - 1; %Total no. of windows
    i = 1;

    for i = 1:length(Data) 
        
        trial = Data(i); %iterates through trials
        trial_data = cell2mat(trial); %data conversion

        for p = 1:(n_windows)
            
            n_bins = round(length(trial_data)/window_ratio); %actual no. of samples in window
            ovlp = n_bins/2; %overlap
            
            window_vec{1} = trial_data(1:62,1:n_bins);%Compute first window 
            
            j = round((n_bins/2) + 1);
            k = round(n_bins + ovlp); %int
            k_float = n_bins + ovlp; %float
            m = 1;
            
            for l = 1:(n_windows - 2)
                %Compute window 2 to n_windows - 1
                n = l + 1;
                window_vec{n} = trial_data(1:62,j:k);
                
                j = ovlp*(m+1); 
                j = round(j + 1);
                k =  round(k_float + n_bins/2); 
               
                l = l+1;
                m = m+1;
            end
            
            window_vec{n_windows} = trial_data(1:62,j:end); %Add final window to vector
            all_trials{i} = window_vec; %iterates to provide full vector 
           
            p = p+1;
        end
        i = i+1;     
    end
    disp(['Saving data to folder ', folders{f}]); %remove this line
    output_folder = [data_path '/' folders{f}];
    save([output_folder '/window_data_Test.mat'], 'all_trials'); %Trial
    f = f+1;
end