%Name: Ciaran Cooney
%Date: 16/02/2018
%Script for formatting simple features for further use.

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

for j = 1:length(folders)
    folder = [data_path '/' folders{j}];
    folder = [folder '/' 'features'];
    data = load([folder '/' 'simple_features.mat']);
    %data = load('basic_features.mat');
    trial_features = data.trial_features;
    all_trial_features = {};
    
    for i=1:length(trial_features)

        t = trial_features{i};

        for j=1:length(t)

            w = t{j};

            for k=1:length(w)
                f = w{k}';
                f = cell2mat(f);
                features{k} = f;  
                d = cell2mat(features);
            end
            feats{j} = d;
        end
        all_trial_features{i} = feats;
    end
    save([folder '/' 'format_features.mat'], 'all_trial_features');
end