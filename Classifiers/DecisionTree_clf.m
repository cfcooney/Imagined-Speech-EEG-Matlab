%Name: Ciaran Cooney
%Date: 02/03/2018
%Decision Tree Classifier using 5-fold cross-validation for EEG data

set = load('set_total_phm'); %data in table format containing features and target labels
set.set_total_phm;
ClassNames = {'/diy/'; '/iy/'; '/m/'; '/n/'; '/piy/'; '/tiy/'; '/uw/'; 'gnaw'; 'knew'; 'pat'; 'pot'};

X_data = set(1:end,2:end);
y_data = set.target;

%returns 'isCategoricalPredictor values depending on length of feature set
%selected for the classifier
if width(set) == 229
    isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
else if width(set) == 343
        isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false];
    else if width(set) == 77
        isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false];
        else if width(set) == 115
                isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,];
            else
                isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false, false, false, false, false, false, false, false, false, false, false, false, false, false];
            end
        end
    end
end

% 5-fold cross validation selected
KFolds = 5;
cvp = cvpartition(y_data, 'KFold', KFolds);
% Initialize the predictions to the proper sizes
validationPredictions = y_data;
n_Observations = size(X_data, 1);
n_Classes = 11;
validationScores = NaN(n_Observations, n_Classes);

for fold = 1:KFolds
    trainingPredictors = X_data(cvp.training(fold), :);
    trainingResponse = y_data(cvp.training(fold), :);
    
    pca_in_train = table2array(varfun(@double, trainingPredictors));
    pca_in_train(isinf(pca_in_train)) = NaN;
    
    [pca_coeffs,score,~,~,explained,mu] = pca(pca_in_train);
    
    explained_variance = 0.95;
    retained_components = find(cumsum(explained)/sum(explained) >= explained_variance, 1);
    pca_coeffs = pca_coeffs(:,1:retained_components);
    trainingPredictors = [array2table(score(:,1:retained_components)), trainingPredictors(:, isCategoricalPredictor)];
    
    model = fitctree(trainingPredictors, trainingResponse,'SplitCriterion','gdi','MaxNumSplits',600,'Surrogate','off','ClassNames',ClassNames);
    
     % Create the result struct with predict function
    pcaTransformationFcn = @(x) [ array2table((table2array(varfun(@double, x(:, ~isCategoricalPredictor))) - mu) * pca_coeffs), x(:,isCategoricalPredictor) ];
    treePredictFcn = @(x) predict(model, x);
    validationPredictFcn = @(x) treePredictFcn(pcaTransformationFcn(x));
    
    % Compute and store validation predictions
    validationPredictors = X_data(cvp.test(fold), :);
    [foldPredictions, foldScores] = validationPredictFcn(validationPredictors);
    
    validationPredictions(cvp.test(fold), :) = foldPredictions;
    validationScores(cvp.test(fold), :) = foldScores;
end

% Compute validation accuracy
correctPredictions = strcmp( strtrim(validationPredictions), strtrim(y_data));
isMissing = cellfun(@(x) all(isspace(x)), y_data, 'UniformOutput', true);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);

disp(["Classifier Accuracy: " validationAccuracy]);