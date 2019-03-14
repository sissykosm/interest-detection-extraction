function Points = BlobsDetection(I,sigma,theta_corn)

n = ceil(3*sigma)*2 + 1;                                           %size of the square matrix of filter G_s
G_s = fspecial('gaussian',n,sigma);                                %create a rotationally symmetric Gaussian lowpass filter
Is = imfilter(I,G_s,'symmetric');                                  %calculate the Laplacian of the image, Is
[Lx,Ly] = gradient(Is);
[Lxx,Lxy] = gradient(Lx);
[Lxy,Lyy] = gradient(Ly);

R = Lxx.*Lyy-Lxy.^2; 
%imshow(1000000000*R);
B_sq = strel('disk',n);
Cond1 = (R == imdilate(R,B_sq));
Cond2 = (R > theta_corn*max(max(R)));
CondPoints = Cond1 & Cond2;
[angles_x,angles_y] = find(CondPoints);
Points = [angles_y angles_x sigma*ones(size(angles_x))];

end

