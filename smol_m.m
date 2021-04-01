function y=smol_m(i)
% Nested polynomial degree + 1
% - i : a Smolyak index, a natural number
% - y : polynomial degree m(i), see Malin, Krueger, and Kubler (2011)
%
% (c) Aliaksandr Zaretski, 2019

if i<1
    error('i < 1');
elseif i==1
    y=1;
else
    y=2^(i-1)+1;
end

end