function Points = HarrisLaplacianBlobs(I,sigma0,N,s,theta_corn)
%function for Multiscale Blobs Detection
%input: image (I),initial standard deviation of the gaussian filter (sigma0)
%threshold (theta_corn), number N of scales, scaling factor s
%output: points of interest that were detected, the scale detected    

sigma = sigma0*(s*ones([1,N])).^(0:N-1);
n = ceil(3*sigma)*2 + 1;                                               %size of the square matrix of filter G_s

for i=1:N   
    %calculate the LoG of the image using the filter
    h = fspecial('log', n(i), sigma(i)); 
    LoG(:,:,i) = sigma(i)^2 * abs(imfilter(I, h,'symmetric'));
end

multiangles_x = [];
multiangles_y = [];
multisigma = [];

for i=1:N
    totalCond = BlobsDetectionCond(I,sigma(i),theta_corn); 
    
    if i == 1
       totalCond = (LoG(:,:,i+1) < LoG(:,:,i))&totalCond; 
    end   
    
    if i>1
       totalCond = (LoG(:,:,i-1) < LoG(:,:,i))&totalCond; 
    end
    
    if i<N
       totalCond = (LoG(:,:,i+1) < LoG(:,:,i))&totalCond; 
    end
    
     if i == N
       totalCond = (LoG(:,:,i-1) < LoG(:,:,i))&totalCond; 
    end
    
    [angles_x,angles_y] = find(totalCond);
    
    multiangles_x = [multiangles_x; angles_x];
    multiangles_y = [multiangles_y; angles_y];
    multisigma = [multisigma; sigma(i)*ones(length(angles_y),1)];
end

Points = [multiangles_y multiangles_x multisigma];

end