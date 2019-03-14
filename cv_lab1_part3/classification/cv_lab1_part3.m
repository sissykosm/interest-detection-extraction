% Part 3

%% 3.1 - Image matching under rotation and scale changes

% add path of detectors and descriptors
addpath(genpath('../matching'));
addpath(genpath('../detectors'));
addpath(genpath('../descriptors'));

%% detector and descriptor functions for the HarrisStephens detector

HS_detector = @(I) HarrisStephens(I,2,2.5,.05,.005);

HS_SURF_descriptor = @(I,points) featuresSURF(I,points);
%get the requested errors using the SURF descriptor 
[HS_SURF_scale_error,HS_SURF_theta_error] = evaluation(HS_detector,HS_SURF_descriptor);

HS_HOG_descriptor = @(I,points) featuresHOG(I,points);
%get the requested errors using the HOG descriptor
[HS_HOG_scale_error,HS_HOG_theta_error] = evaluation(HS_detector,HS_HOG_descriptor);

%% detector and descriptor functions for the HarrisLaplacian detector
HL_detector = @(I) HarrisLaplacian(I,2,2.5,4,1.5,.05,.005);

HL_SURF_descriptor = @(I,points) featuresSURF(I,points);
%get the requested errors using the SURF descriptor 
[HL_SURF_scale_error,HL_SURF_theta_error] = evaluation(HL_detector,HL_SURF_descriptor);

HL_HOG_descriptor = @(I,points) featuresHOG(I,points);
%get the requested errors using the HOG descriptor
[HL_HOG_scale_error,HL_HOG_theta_error] = evaluation(HL_detector,HL_HOG_descriptor);

%% detector and descriptor functions for the Blobs detector
B_detector = @(I) BlobsDetection(I,2,.005);

B_SURF_descriptor = @(I,points) featuresSURF(I,points);
%get the requested errors using the SURF descriptor 
[B_SURF_scale_error,B_SURF_theta_error] = evaluation(B_detector,B_SURF_descriptor);

B_HOG_descriptor = @(I,points) featuresHOG(I,points);
%get the requested errors using the HOG descriptor
[B_HOG_scale_error,B_HOG_theta_error] = evaluation(B_detector,B_HOG_descriptor);

%% detector and descriptor functions for the multiscale Blobs detector
HLB_detector = @(I) HarrisLaplacianBlobs(I,2,4,1.5,.005);

HLB_SURF_descriptor = @(I,points) featuresSURF(I,points);
%get the requested errors using the SURF descriptor 
[HLB_SURF_scale_error,HLB_SURF_theta_error] = evaluation(HLB_detector,HLB_SURF_descriptor);

HLB_HOG_descriptor = @(I,points) featuresHOG(I,points);
%get the requested errors using the HOG descriptor
[HLB_HOG_scale_error,HLB_HOG_theta_error] = evaluation(HLB_detector,HLB_HOG_descriptor);

%% detector and descriptor functions for the multiscale Boxfiltering detector
BF_detector = @(I) BoxFilteringMulti(I,.05,2,4,1.5);

BF_SURF_descriptor = @(I,points) featuresSURF(I,points);
%get the requested errors using the SURF descriptor 
[BF_SURF_scale_error,BF_SURF_theta_error] = evaluation(BF_detector,BF_SURF_descriptor);

BF_HOG_descriptor = @(I,points) featuresHOG(I,points);
%get the requested errors using the HOG descriptor
[BF_HOG_scale_error,HS_HOG_theta_error] = evaluation(BF_detector,BF_HOG_descriptor);

%% 3.2 - Image Classification

%3.2.1

HL_SURF_features = FeatureExtraction(HL_detector,HL_SURF_descriptor);
HL_HOG_features = FeatureExtraction(HL_detector,HL_HOG_descriptor);

HLB_SURF_features = FeatureExtraction(HLB_detector,HLB_SURF_descriptor);
HLB_HOG_features = FeatureExtraction(HLB_detector,HLB_HOG_descriptor);

BF_SURF_features = FeatureExtraction(BF_detector,BF_SURF_descriptor);
BF_HOG_features = FeatureExtraction(BF_detector,BF_HOG_descriptor);

%3.2.2
addpath(genpath('libsvm-3.17'));

classifier(HL_SURF_features);
classifier(HL_HOG_features);
classifier(HLB_SURF_features);
classifier(HLB_HOG_features);
classifier(BF_SURF_features);
classifier(BF_HOG_features);