%Name: Ciaran Cooney
%Date: 16/02/2018
%Script for formatting complex features for further use.

addpath(genpath('C:\Users\SB00745777\OneDrive - Ulster University\Matlab'));

folders = {'P02', 'MM05', 'MM08', 'MM09', 'MM10', 'MM11', 'MM12', 'MM14'};
folders = [folders {'MM15', 'MM16', 'MM18', 'MM19', 'MM20', 'MM21'}];

data_path = 'C:\Users\SB00745777\OneDrive - Ulster University\Matlab\KaraOne Data';

features = {'format_features_FD.mat','format_features_hurst.mat',};
features = [features {'format_features_spec_ent.mat','format_features_spec_pow.mat'}];
features = [features {'format_features_magnitude.mat','format_features_phase.mat'}];
%'format_features_magnitude' 'format_features_phase'

for i = 1:length(folders)
    folder = [data_path '/' folders{i}];
    folder = [folder '/' 'features'];
    feature_set = {};
    for j=1:length(features)
        data{j} = load([folder '/' features{j}]);
    end
    
    fd = data{1}.feats;
    h_exp = data{2}.feats;
    spec_ent = data{3}.feats;
    spec_pow = data{4}.feats;
    mag = data{5}.subject_mag;
    phase = data{6}.subject_ph;
    
    for k=1:length(fd)
        a = fd{k};
        b = h_exp{k};
        c = spec_ent{k};
        d = spec_pow{k};
        e = mag{k};
        f = phase{k};
        
        feature_set{k} = [a,b,c,d,e,f];
    end
    save([folder '/' 'format_features_mag_ph' '.mat'], 'feature_set');
end

