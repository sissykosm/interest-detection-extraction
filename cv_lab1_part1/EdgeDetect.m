function D = EdgeDetect(I, sigma, theta, LaplacType)
%function for Edge Detection 
%input: Image, sigma, theta, LaplacianType(0 Linear/1 Non Linear)
%output: D matrix, binary image of edges
    
    n = ceil(3*sigma)*2 + 1;                                            %size of the square matrix of filter 
    h1 = fspecial('gaussian', n, sigma);                                %create a rotationally symmetric Gaussian lowpass filter     
    h2 = fspecial('log', n, sigma);                                     %create a rotationally symmetric Laplacian of Gaussian filter
    Is = imfilter(I, h1);                                               %calculate the Laplacian of the image, Is
    
    NHOOD = [0 1 0; 1 1 1; 0 1 0];                                      %create a flat structuring element where NHOOD specifies the neighborhood
    SE = strel('arbitrary', NHOOD);                                     %for the calculation of the Non Linear Laplacian

    if LaplacType == 0 
        L = imfilter(I, h2);
    elseif LaplacType == 1
        L = imdilate(Is,SE)+imerode(Is,SE)-2*Is;
    else disp('Error: LaplacType is 0 or 1.'); 
    end
    
    %transformation to binary image and calculation of its contour Y
    X = (L >= 0);
    Y = imdilate(X,SE)-imerode(X,SE);
    
    %selection of the wanted zerocrossings 
    %and creation of the image of edges, D
    [gr_X, gr_Y] = gradient(Is);
    Is_gr = (gr_X.^2 + gr_Y.^2).^(1/2);
    thr = theta*max(max(Is_gr));
    D = Y & (Is_gr > thr);
end