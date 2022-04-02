function [Dist,D]=dtw_distanca(t,r)
% Dynamic Time Warping 
% Dist - slicnost signala
% D - matrica rastojanja

[rows,N]=size(t);
[rows,M]=size(r);

d=abs((repmat(t(:),1,M)-repmat(r(:)',N,1))); 
D=zeros(size(d));
D(1,1)=d(1,1);
for n=2:N
    D(n,1)=d(n,1)+D(n-1,1);
end
for m=2:M
    D(1,m)=d(1,m)+D(1,m-1);
end
for n=2:N
    for m=2:M
        D(n,m)=d(n,m)+min([D(n-1,m),D(n-1,m-1),D(n,m-1)]);
    end
end

% Slicnost ulaznih signala
Dist = D(N,M);
end