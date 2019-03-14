%% Part 1 - 1.1 Input Image Processing
I0 = imread('edgetest_18.png');                                 %read the given image
I0 = im2double(I0);                                             %convert the intensity image to double precision
figure(1);
imshow(I0);
title('Initial Image I0');

%add Gaussian noise with zero mean 
%and 2 different types of variance(sigma_n)to the given image 
Imax = max(max(I0));
Imin = min(min(I0));

sigma_n1 = (Imax - Imin)/10;                                    %standard deviation for PSNR=20dB, noisy image I1
I1 = imnoise(I0,'gaussian',0,(sigma_n1^2));
figure(2);
imshow(I1);
title('I0 with Gaussian noise, PSNR=20dB');

sigma_n2 = (Imax - Imin)/(10^(1/2));                            %standard deviation for PSNR=10dB, noisy image I2
I2 = imnoise(I0,'gaussian',0,(sigma_n2^2));
figure(3);
imshow(I2);
title('I0 with Gaussian noise, PSNR=10dB');

%% Part 1 - 1.2 Edge Detection
%Call function EdgeDetect 
%with various inputs (Image, sigma, theta, LaplacianType(0 Linear/1 NonLinear))

sigma = 1.5;
theta_edge = .2;
LaplacType = 0;
D1 = EdgeDetect(I1, sigma, theta_edge, LaplacType);
figure(4);
imshow(D1);
title('Binary Image of edges with ó=1.5,è_e_d_g_e=0.2,PSNR=20dB,LaplacType=0');

LaplacType = 1;
D2 = EdgeDetect(I1, sigma, theta_edge, LaplacType);
figure(5);
imshow(D2);
title('Binary Image of edges with ó=1.5,è_e_d_g_e=0.2,PSNR=20dB,LaplacType=1');

sigma = 3;
LaplacType = 0;
D3 = EdgeDetect(I2, sigma, theta_edge, LaplacType);
figure(6);
imshow(D3);
title('Binary Image of edges with ó=3,è_e_d_g_e=0.2,PSNR=10dB,LaplacType=0');

LaplacType = 1;
D4 = EdgeDetect(I2, sigma, theta_edge, LaplacType);
figure(7);
imshow(D4);
title('Binary Image of edges with ó=3,è_e_d_g_e=0.2,PSNR=10dB,LaplacType=1');

%% Part 1 - 1.3 Evaluation of Results 
%calculation of the binary image of real edges T
%create a flat structuring element where NHOOD specifies the neighborhood for dilation and erosion

theta_real = .2;
NHOOD = [0 1 0; 1 1 1; 0 1 0];
SE = strel('arbitrary', NHOOD);
M = imdilate(I0,SE)-imerode(I0,SE);
T = (M > theta_real);
figure(8);
imshow(T);
title('Binary Image of real edges');

%evaluation for linear filtering and PSNR=20dB
[Cbest,sigmaBest,thetaBest,Dbest] = calcBestResult(I1,T,0);             
figure(9);
imshow(Dbest);
title('Best Binary Image of edges with PSNR=20dB,LaplacType=0');
disp(['For linear filtering and PSNR=20dB: sigmaBest=',num2str(sigmaBest), ...
      ', theta_best=',num2str(thetaBest),', C_best=',num2str(Cbest)]);

%evaluation for non-linear filtering and PSNR=20dB
[Cbest,sigmaBest,thetaBest,Dbest] = calcBestResult(I1,T,1);
figure(10);
imshow(Dbest);
title('Best Binary Image of edges with PSNR=20dB,LaplacType=1');
disp(['For non-linear filtering and PSNR=20dB: sigmaBest=',num2str(sigmaBest), ...
      ', theta_best=',num2str(thetaBest),', C_best=',num2str(Cbest)]);

%evaluation for linear filtering and PSNR=10dB 
[Cbest,sigmaBest,thetaBest,Dbest] = calcBestResult(I2,T,0);
figure(11);
imshow(Dbest);
title('Best Binary Image of edges with PSNR=10dB,LaplacType=0');
disp(['For linear filtering and PSNR=10dB: sigmaBest=',num2str(sigmaBest), ...
      ', theta_best=',num2str(thetaBest),', C_best=',num2str(Cbest)]);

%evaluation for non-linear filtering and PSNR=10dB  
[Cbest,sigmaBest,thetaBest,Dbest] = calcBestResult(I2,T,1);
figure(12);
imshow(Dbest);
title('Best Binary Image of edges with PSNR=10dB,LaplacType=1');
disp(['For non-linear filtering and PSNR=10dB: sigmaBest=',num2str(sigmaBest), ...
      ', theta_best=',num2str(thetaBest),', C_best=',num2str(Cbest)]);

%% Part 1 - 1.4 Applying Edge-Detection Algorithms on Real Images
I3 = imread('venice1_edges.png');                                 %read the given image
I3 = im2double(I3);                                             %convert the intensity image to double precision
figure(13);
imshow(I3);
title('Initial Image I3');

%Call function EdgeDetect 
%with various inputs (Image, sigma, theta, LaplacianType(0 Linear/1 NonLinear))

sigma = 1.5;
theta_edge = .2;
LaplacType = 0;
D5 = EdgeDetect(I3, sigma, theta_edge, LaplacType);
figure(14);
imshow(D5);
title('Binary Image of edges with ó=1.5,è_e_d_g_e=0.2,LaplacType=0');

LaplacType = 1;
D6 = EdgeDetect(I3, sigma, theta_edge, LaplacType);
figure(15);
imshow(D6);
title('Binary Image of edges with ó=1.5,è_e_d_g_e=0.2,LaplacType=1');

sigma = 3;
LaplacType = 0;
D7 = EdgeDetect(I3, sigma, theta_edge, LaplacType);
figure(16);
imshow(D7);
title('Binary Image of edges with ó=3,è_e_d_g_e=0.2,LaplacType=0');

LaplacType = 1;
D8 = EdgeDetect(I3, sigma, theta_edge, LaplacType);
figure(17);
imshow(D8);
title('Binary Image of edges with ó=3,è_e_d_g_e=0.2,LaplacType=1');

%Best Binary Image of edges
sigma = 2;
theta_edge = 0.18;
LaplacType = 1;
Dtest = EdgeDetect(I3, sigma, theta_edge, LaplacType);
figure(18);
imshow(Dtest);
title('Best Binary Image of edges');