% Name: Ciaran Cooney
% Date: 09/02/2018
% Script for computing basic features of an EEG dataset
% Input data is 131-165 trials with 19 windows @ 62*500 samples

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

for h = 1:length(folders)
    
    disp(['Computing features for folder ' folders{h}]);
    folder = [data_path '/' folders{h}];
    file = [folder '/' 'window_data_test'];
    Trial = load(file);
    Trial = Trial.Tri;
    for i = 1:length(Trial)
        window = Trial{i};
        for j = 1:19
            frame = window{j};
            mn = {};
            absmn = {};
            sd = {};
            sm = {};
            md = {};
            vr = {};
            mx = {};
            absmx = {};
            mnm = {};
            absmin = {};
            mxmn = {};
            mnmx = {};
            for k = 1:62
                chan = double(frame(k,:));

                % 12 cells @ 62*1
                mn{k} = mean(chan);
                absmn{k} = abs(mean(chan));
                sd{k} = std(chan);
                sm{k} = sum(chan);
                md{k} = median(chan);
                vr{k} = var(chan);
                mx{k} = max(chan);
                absmx{k} = abs(max(chan));
                mnm{k} = min(chan);
                absmin{k} = abs(min(chan));
                mxmn{k} = max(chan)+min(chan);
                mnmx{k} = max(chan)-min(chan);
                
                k = k+1;
            end
            % 12 cells @ (62*19)
            mean_features{j} = mn;
            absmean_features{j} = absmn;
            std_features{j} = sd;
            sum_features{j} = sm;
            med_features{j} = md;
            var_features{j} = vr;
            max_features{j} = mx;
            absmax_features{j} = absmx;
            min_features{j} = mnm;
            absmin_features{j} = absmin;
            mx_mn_features{j} = mxmn;
            mn_mx_features{j} = mnmx;
            

            j = j + 1;
        end
        % 131-165 cells @ 12 feature cells * (62*19)
        trial_features{i} = {mean_features, absmean_features, std_features, sum_features,...
            med_features,var_features, max_features, absmax_features, min_features,...
            absmin_features, mx_mn_features, mn_mx_features};
        
        
        i = i + 1;
    end
    disp(['Saving features to folder ', folders{h}]);
    output_data_path = [folder '\' 'features'];
    save([output_data_path '/trial_features.mat'], 'trial_features');
    h = h + 1;
end