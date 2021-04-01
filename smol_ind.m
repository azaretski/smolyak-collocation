function y=smol_ind(d,mu)
% Smolyak grid indices
% - d  : state-space dimension, a natural number
% - mu : a non-negative integer measuring how fine the grid is; see Malin,
% Krueger, and Kubler (2011)
% - y  : indices, each row corresponds to a grid point in R^d
%
% (c) Aliaksandr Zaretski, 2019

if d==1
    y=d+mu;
    return;
end
ind=NaN((mu+1)^d,d);
ind(1,:)=1;
cont=1;
j=d-1;
i=1;
while cont==1
    i=i+1;
    ind(i,:)=ind(i-1,:);
    while j<d-1 && ind(i,j)<=mu+j-sum(ind(i,1:j-1))
        j=j+1;
    end
    if j==d-1
        ind(i,j)=ind(i,j)+1;
    end
    while j>1 && ind(i,j)>mu+j-sum(ind(i,1:j-1))
        ind(i,j)=1;
        ind(i,j-1)=ind(i,j-1)+1;
        j=j-1;
    end
    if j==1 && ind(i,j)>mu+1
        i=i-1;
        cont=0;
    end
end
ind(1:i,d)=mu+d-sum(ind(1:i,1:d-1),2);
y=ind(1:i,:);

end