clear; clc;
addpath(genpath('libsvm-3.17'));

%% Feature Extraction
% add here your detector/descriptor functions i.e.
detector_func = @(I) HarrisLaplacian(I,2,1.5,5,2.5,.005);
descriptor_func = @(I,points) featuresSURF(I,points);

features = FeatureExtraction(detector_func,descriptor_func);

%% Image Classification
parfor k=1:2
    %% Split train and test set
    [data_train,label_train,data_test,label_test]=createTrainTest(features,k);
    %% Bag of Words
    [BOF_tr,BOF_ts]=BagOfWords(data_train,data_test);
    %% SVM classification
    [percent(k),KMea] = svm(BOF_tr,label_train,BOF_ts,label_test);
    fprintf('Classification Accuracy: %f %%\n',percent(k)*100);
end

fprintf('Average Classification Accuracy: %f %%\n',mean(percent)*100);