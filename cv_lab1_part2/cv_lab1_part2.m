%% Part 2 - Interest Point Detection
%2.1 - Angle Detection

I1Color = imread('Caravaggio2.jpg');  %read the given image
I1Color = im2double(I1Color);   %convert the intensity image to double precision
I1 = rgb2gray(I1Color);
figure(1);
imshow(I1);
title('Initial Image I1');

I2Color = imread('sunflowers18.png');  %read the given image
I2Color = im2double(I2Color);   %convert the intensity image to double precision
I2 = rgb2gray(I2Color);
figure(2);
imshow(I2);
title('Initial Image I2');

%set sigma, r, k, theta_corn parameters
sigma = 2;
r = 2.5;
k = 0.05;
theta_corn = 0.005;
Points1 = HarrisStephens(I1,sigma,r,k,theta_corn);
figure(3);
interest_points_visualization(I1Color,Points1);

k = 0.01;
theta_corn = 0.003;
Points2 = HarrisStephens(I2,sigma,r,k,theta_corn);
figure(4);
interest_points_visualization(I2Color,Points2);

%% 2.2 Multiscale Angle detection
sigma0 = 2;
r0 = 2.3;
k = 0.05;
theta_corn = 0.004;
s = 1.6;
N = 5;

Points1 = HarrisLaplacian(I1,sigma0,r0,N,s,k,theta_corn);
figure(5);
interest_points_visualization(I1Color,Points1);

r0 = 2.1;
s = 1.4;
N = 6;
Points2 = HarrisLaplacian(I2,sigma0,r0,N,s,k,theta_corn);
figure(6);
interest_points_visualization(I2Color,Points2);

%% 2.3 - Blobs detection
%set sigma, theta_corn parameters
sigma = 2.5;
theta_corn = 0.08;
Points1 = BlobsDetection(I1,sigma,theta_corn);
figure(7);
interest_points_visualization(I1Color,Points1);

sigma = 2.7;
Points2 = BlobsDetection(I2,sigma,theta_corn);
figure(8);
interest_points_visualization(I2Color,Points2);

%% 2.4 - Multiscale Blobs detection
sigma0 = 2.6;
theta_corn = 0.08;
s = 1.6;
N = 5;
Points1 = HarrisLaplacianBlobs(I1,sigma0,N,s,theta_corn);
figure(9);
interest_points_visualization(I1Color,Points1);

sigma0 = 2.5;
theta_corn = 0.07;
s = 1.5;
N = 5;
Points2 = HarrisLaplacianBlobs(I2,sigma0,N,s,theta_corn);
figure(10);
interest_points_visualization(I2Color,Points2);

%% 2.5 - Box Filters and Integral Images
sigma = 2;
theta_corn = 0.07;
Points1 = BoxFiltering(I1,theta_corn,sigma);
figure(11);
interest_points_visualization(I1Color,Points1);

sigma = 2.7;
Points2 = BoxFiltering(I2,theta_corn,sigma);
figure(12);
interest_points_visualization(I2Color,Points2);

%compare the criterion R between 2.3 and 2.5 - uncomment imshow(R) in functions 
%{
sigma = 2;
figure(13);
Points = BoxFiltering(I1,theta_corn,sigma);
figure(14);
Points = BlobsDetection(I1,sigma,theta_corn);

sigma = 4;
figure(15);
Points = BoxFiltering(I1,theta_corn,sigma);
figure(16);
Points = BlobsDetection(I1,sigma,theta_corn);

sigma = 6;
figure(17);
Points = BoxFiltering(I1,theta_corn,sigma);
figure(18);
Points = BlobsDetection(I1,sigma,theta_corn);
%}

%Multiscale feature Detection
sigma0 = 2;
theta_corn = 0.07;
s = 1.5;
N = 5;
Points1 = BoxFilteringMulti(I1,theta_corn,sigma0,N,s);
figure(19);
interest_points_visualization(I1Color,Points1);

theta_corn = 0.05;
Points2 = BoxFilteringMulti(I2,theta_corn,sigma0,N,s);
figure(20);
interest_points_visualization(I2Color,Points2);