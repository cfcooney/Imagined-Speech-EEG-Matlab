addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab';
output_data_path = [data_path '\' 'KaraOne Data'];
ICA = false;

for j=1:length(folders)
    
    disp(['Computing EEG Data for folder ' folders{j}]);
    folder = [data_path '/' folders{j}];
    D = dir([folder '/*.set']);
    set_fn = [folder '/' D(1).name];
    
    kinect_folder = [folder '/kinect_data']; %Required for extracting prompts
    labels_fn = [kinect_folder '/labels.txt'];
    
    EEG = pop_loadset(set_fn);
    data = EEG.data;
    
    simple = true;
    if ICA
        W = EEG.icaweights * EEG.icasphere;
    else
        W = eye(62, 62);
    end
    
    disp('Splitting the data');
    load([folder '/epoch_inds.mat']);
    
    thinking_mats = split_data(thinking_inds, data); %EEG data segemnted by trial
    epoch_data.thinking_mats = thinking_mats;
    
     % Getting the prompts.
    prompts = table2cell(readtable(labels_fn,'Delimiter',' ','ReadVariableNames',false));
     % Creating and saving the struct.
    disp('saving the struct');
     %%
    EEG_Data = struct();
   
    EEG_Data.prompts = prompts;
    EEG_Data.EEG = thinking_mats;
    EEG_Data.Data = data;
    %%
    output_folder = [output_data_path '/' folders{j}];
    save([output_folder '/EEG_Data.mat'], 'EEG_Data');

end 

