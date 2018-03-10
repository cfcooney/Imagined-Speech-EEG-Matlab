addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

wdw_len = 500;

for i=1:length(folders)
    
    disp(['Computing zero-padded windows for ' folders{i}]);
    folder = [data_path '/' folders{i}];
    file = [folder '/' 'window_data'];
    Trial = load(file);
    Trial = Trial.all_trials;
    window_pad_trial = {};
     for j=1:length(Trial)
        window = Trial{j};
        for k=1:length(window)
            w = window{k};
            if(length(w) > wdw_len)
                w = w(1:62,1:wdw_len);
            else if(length(w) < wdw_len)
                w= padding(w,wdw_len);
                end
            end
            window_pad{k} = w; 
        end
        window_pad_trial{j} = window_pad;
     end
     disp(['Saving data to folder ', folders{i}]); %remove this line
     output_folder = [data_path '/' folders{i}];
     save([output_folder '/window_data_pad.mat'], 'window_pad_trial'); %Trial
end