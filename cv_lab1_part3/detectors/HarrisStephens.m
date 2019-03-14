function Points = HarrisStephens(I,sigma,r,k,theta_corn)
%function for Corner Detection
%input: image (I),standard deviations of the two gaussian filters (sigma,r),threshold (theta_corn)
%output: points of corners that were detected

n1 = ceil(3*sigma)*2 + 1;                                           %size of the square matrix of filter G_s
n2 = ceil(3*r)*2 + 1;                                               %size of the square matrix of filter G_r
G_s = fspecial('gaussian', n1, sigma);                              %create a rotationally symmetric Gaussian lowpass filter
G_r = fspecial('gaussian', n2, r);                                  %create a rotationally symmetric Gaussian lowpass filter

Is = imfilter(I, G_s,'symmetric');                                              %calculate the Laplacian of the image, Is
[gr_X, gr_Y] = gradient(Is);

J1 = imfilter((gr_X .* gr_X), G_r);
J2 = imfilter((gr_X .* gr_Y), G_r);
J3 = imfilter((gr_Y .* gr_Y), G_r);

%calculate the eigenvalues of J
l1 = .5*(J1 + J3 + sqrt((J1 - J3).^2 + 4*J2.^2));
l2 = .5*(J1 + J3 - sqrt((J1 - J3).^2 + 4*J2.^2));

%calculate cornerness criterion
R = l2.*l1 - k*(l1 + l2).^2;                                      
B_sq = strel('disk',n1);
Cond1 = (R == imdilate(R,B_sq));
Cond2 = (R > theta_corn*max(max(R)));
CondPoints = Cond1 & Cond2;
[angles_x,angles_y] = find(CondPoints);
Points = [angles_y angles_x sigma*ones(size(angles_x))]; 

end