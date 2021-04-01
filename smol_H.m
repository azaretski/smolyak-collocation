function y=smol_H(d,mu)
% Smolyak grid construction
% - d  : state-space dimension, a natural number
% - mu : a non-negative integer measuring how fine the grid is; see Malin,
% Krueger, and Kubler (2011) "Solving the multi-country real business cycle
% model using a Smolyak-collocation method", Journal of Economic Dynamics &
% Control for details
% - y  : Smolyak grid, each row is a point in R^d
%
% (c) Aliaksandr Zaretski, 2019

ind=smol_ind(d,mu);             % Smolyak indices
nind=size(ind,1);
y=NaN(smol_m(mu+1)^d*nind,d);	% preallocate grid
grids=cell(nind,d);             % univariate grids
dims=NaN(nind,d);               % dimensions of univariate grids
p=0;
for i=1:nind
    for j=1:d
        grids{i,j}=G(smol_m(ind(i,j)));
        dims(i,j)=numel(grids{i,j});
    end
    mult_ind=ones(1,d); % multi-index for each Cartesian product
    k=d;
    cont=1;
    while cont==1
        p=p+1;
        for q=1:d
            y(p,q)=grids{i,q}(mult_ind(q));
        end
        upd_ind=1;    % update multi-index
        while upd_ind==1 && k>0
            if mult_ind(k)<dims(i,k)
                mult_ind(k)=mult_ind(k)+1;
                upd_ind=0;
                k=d;
            else
                mult_ind(k)=1;
                k=k-1;
            end
        end
        if k==0
            cont=0;
        end
    end
end
y=unique(round(y(1:p,:),6),'rows');

end

% Univariate grid
function y=G(n)
y=NaN(n,1);
if n<1
    error('n < 1');
elseif n==1
    y(1)=0;
else
    for j=1:n
        y(j)=-cos(pi*(j-1)/(n-1));
    end
end
end