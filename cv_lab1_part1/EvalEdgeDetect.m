function C = EvalEdgeDetect(D,T)
%function for evaluation of the edge-detection results
%input: binary image of edges (D),binary image of real edges (T) 
%output: quality criterion

A = D & T;                              %intersection of both binary images
PrD_T = sum(A(:))/sum(D(:));            %rate of detected edges that are real (Precision)
PrT_D = sum(A(:))/sum(T(:));            %rate of real edges that are detected (Recall)
C = (PrD_T + PrT_D)/2;

end

