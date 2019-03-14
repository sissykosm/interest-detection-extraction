function [Cbest,sigmaBest,thetaBest,Dbest] = calcBestResult(I,T,LaplacType)
%function to find the pair (sigma,èedge) that gives the best criterion 
%input: image (I), binary image of real edges(T), LaplacianType (0 Linear/1 Non Linear)  
%output: the best criterion and the respective sigma,èedge,binary image of edges

Cbest = -1;
for sigma = 1.4:0.1:2
    for theta = .1:.05:.5
        D = EdgeDetect(I,sigma,theta,LaplacType);
        C = EvalEdgeDetect(D,T);
        if C > Cbest
            sigmaBest = sigma;
            thetaBest = theta;
            Cbest = C;
            Dbest = D;
        end
    end
end

end

