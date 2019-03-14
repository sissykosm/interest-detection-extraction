function Points = BoxFilteringMulti(I,theta_corn,sigma0,N,s)

sigma = sigma0*(s*ones([1,N])).^(0:N-1);
n = ceil(3*sigma)*2 + 1;                                               %size of the square matrix of filter G_s

for i=1:N                                               
    %calculate the LoG of the image using the filter
    h = fspecial('log', n(i), sigma(i)); 
    LoG(:,:,i) = sigma(i)^2 * abs(imfilter(I, h,'symmetric'));
end

multi_x = [];
multi_y = [];
multisigma = [];

for i=1:N

    CondPoints = BoxFilteringCond(I,theta_corn,sigma(i)); 
    
    if i == 1
       CondPoints = (LoG(:,:,i+1) < LoG(:,:,i))&CondPoints; 
    end   
    
    if i>1
       CondPoints = (LoG(:,:,i-1) < LoG(:,:,i))&CondPoints; 
    end
    
    if i<N
       CondPoints = (LoG(:,:,i+1) < LoG(:,:,i))&CondPoints; 
    end
    
    if i == N
       CondPoints = (LoG(:,:,i-1) < LoG(:,:,i))&CondPoints; 
    end
    
    [points_x,points_y] = find(CondPoints);
    
    multi_x = [multi_x; points_x];
    multi_y = [multi_y; points_y];
    multisigma = [multisigma; sigma(i)*ones(length(points_y),1)];
end

Points = [multi_y multi_x multisigma];

end

