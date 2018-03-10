%Name: Ciaran Cooney
%Date: 10/03/2018
%Script for computing cells and tabularising features for simple, complex
%and a combination of both types of features.

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';
n_chan = 62;
for i=1:length(folders)
    folder = [data_path '/' folders{i}];
    folder = [folder '/' 'features'];
    simple = load([folder '/' 'format_features.mat']);
    simple = simple.all_trial_features;
    complex = load([folder '/' 'format_features_mag_ph.mat']);
    complex = complex.feature_set;
    trial_data_s = {};
    trial_data_c = {};
    trial_data_all = {};
    n_chan=62;
    for j=1:length(complex)
        data_s = [];
        data_c = [];
        trial_s = simple{j};
        trial_c = complex{j};
        for l=1:length(trial_s)
            trial_feature = trial_s{l};
            for k=1:n_chan
                ch_s = trial_feature(k,1:end);
                data_s = [data_s,ch_s];
            end
        end
        for m=1:n_chan
            ch_c = trial_c(m,1:end);
            data_c = [data_c,ch_c];
        end
        trial_data_s{j} = data_s;
        trial_data_c{j} = data_c;
        trial_data_all{j} = [data_s,data_c]; 
    end
    load([folder '/' 'labels.mat']);
    tbl_s = trial_data_s';  
    tbl_c = trial_data_c'; 
    tbl_all = trial_data_all';
    tbl_s = cell2mat(tbl_s);
    tbl_s = table(tbl_s,labels);
    tbl_c = cell2mat(tbl_c);
    tbl_c = table(tbl_c,labels);
    tbl_all = cell2mat(tbl_all);
    tbl_all = table(tbl_all,labels);
    save([folder '/' 'tbl_s.mat'], 'tbl_s');
    save([folder '/' 'tbl_c.mat'], 'tbl_c');
    save([folder '/' 'tbl_all.mat'], 'tbl_all');
    save([folder '/' 'trial_data_s.mat'], 'trial_data_s');
    save([folder '/' 'trial_data_c.mat'], 'trial_data_c');
    save([folder '/' 'trial_data_all.mat'], 'trial_data_all');
end
            
            
        