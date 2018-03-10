function [Train_X,Test_X,Train_y,Test_y] = train_test_split(x,y,trn_sp,tst_sp,val_sp)
% Function for splitting dataset into train and test setd for
% classification.
%     
%     INPUTS
%     x = feature set
%     y = labels
%     trn_sp = training set ratio; default: 0.8
%     tst_sp = test set ratio; default: 0.2
%     val_sp = validation det ration; default: 0.0
%     val_sp is an input (not required) to 'dividerand' function' used below 
%
%     OUTPUTS
%     Train_X = randomised subsection of data for training
%     Test_X = randomised subsection of data for testing
%     Train_y = randomised subsection of label data for training
%     Test_y = randomised subsection of lavel data for testing
%
%     Name: Ciaran Cooney
%     Date: 02/03/2018
if nargin < 3;    trn_sp = 0.8;               end
if nargin < 4;    tst_sp = 1-trn_sp;          end
if nargin < 5;    val_sp = 1-(trn_sp+tst_sp); end

len = height(x);
[trainInd,validatInd,testInd] = dividerand(len,trn_sp,val_sp,tst_sp);

Train_X = x(trainInd,1:end);
Test_X = x(testInd,1:end);
Train_y = y(trainInd);
Test_y = y(testInd);