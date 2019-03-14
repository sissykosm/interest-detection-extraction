function CondPoints = BoxFilteringCond(I,theta_corn,sigma)

%2.5.1
n = 2*ceil(3*sigma) + 1;
h = 4*floor(n/6) + 1;
w = 2*floor(n/6) + 1;
a = floor(h/2);
b = floor(w/2);

Iext = padarray(I,[b+w,b+w],'symmetric');
Iint = cumsum(cumsum(Iext,2),1);

%2.5.2
%Calculate Dxx
Dxx = 3*imtranslate(Iint,[b+1, -a])+3*imtranslate(Iint,[-b, a+1])-3*imtranslate(Iint,[-b, -a]) ...
    -3*imtranslate(Iint,[b+1, a+1])+imtranslate(Iint,[b+w+1, a+1])-imtranslate(Iint,[b+w+1, -a])...
    +imtranslate(Iint,[-b-w, -a])-imtranslate(Iint,[-b-w, a+1]);
Dxx = Dxx(b+w+1:(end-(b+w)),b+w+1:(end-(b+w)));
	
%Calculate Dyy
Dyy = 3*imtranslate(Iint,[-a, b+1])+3*imtranslate(Iint,[a+1, -b])-3*imtranslate(Iint,[-a, -b]) ...
    -3*imtranslate(Iint,[a+1, b+1])+imtranslate(Iint,[a+1, b+w+1])-imtranslate(Iint,[-a, b+w+1])...
    +imtranslate(Iint,[-a, -b-w])-imtranslate(Iint,[a+1, -b-w]);
Dyy = Dyy(b+w+1:(end-(b+w)),b+w+1:(end-(b+w)));
	
%Calculate Dxy
Dxy = (imtranslate(Iint,[-w, -w])+Iint-imtranslate(Iint,[-w, 0])-imtranslate(Iint,[0, -w])) ...
    -(imtranslate(Iint,[-w, 1])+imtranslate(Iint,[0, w+1])-imtranslate(Iint,[-w, w+1])-imtranslate(Iint,[0, 1])) ...
    -(imtranslate(Iint,[1, -w])+imtranslate(Iint,[w+1, 0])-imtranslate(Iint,[1, 0])-imtranslate(Iint,[w+1, -w])) ...
    +(imtranslate(Iint,[1, 1])+imtranslate(Iint,[w+1, w+1])-imtranslate(Iint,[1, w+1])-imtranslate(Iint,[w+1, 1]));
Dxy = Dxy(b+w+1:(end-(b+w)),b+w+1:(end-(b+w)));

%2.5.3
R = Dxx.*Dyy-(.9*Dxy).^2;
%imshow(R);
B_sq = strel('disk',n);
Cond1 = (R == imdilate(R,B_sq));
Cond2 = (R > theta_corn*max(max(R)));
CondPoints = Cond1 & Cond2;

end