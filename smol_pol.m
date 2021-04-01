function y=smol_pol(d,mu)
% Smolyak interpolating polynomial
% - d  : state-space dimension, a natural number
% - mu : a non-negative integer measuring how fine the grid is; see Malin,
% Krueger, and Kubler (2011)
% - y  : matrix of univariate polynomial degrees, each row is a set of
% degrees defining a product polynomial; the number of the latter---the
% number of rows of y---equals the number of Smolyak grid points
%
% (c) Aliaksandr Zaretski, 2019

mus=max([d,mu+1])-d:mu;
nmus=numel(mus);
inds=cell(nmus,1);	% collects polynomial indices
for i=1:nmus
    inds{i}=smol_ind(d,mus(i));
end
ind=cell2mat(inds);
nind=size(ind,1);
m_ind=NaN(size(ind));	% collects m(i_j) for each univariate index
for j=1:d
    for i=1:nind
        m_ind(i,j)=smol_m(ind(i,j));
    end
end
pol_ind=NaN(sum(prod(m_ind,2)),d);  % indices of univariate polynomials in products
p=0;
for i=1:nind
    mult_ind=ones(1,d); % multi-index for each product polynomial
    k=d;
    cont=1;
    while cont==1
        p=p+1;
        pol_ind(p,:)=mult_ind;
        upd_ind=1;    % update multi-index
        while upd_ind==1 && k>0
            if mult_ind(k)<m_ind(i,k)
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
pol_ind=unique(pol_ind(1:p,:),'rows');
y=pol_ind-1;

end