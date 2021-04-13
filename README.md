# smolyak-collocation
Construction of a Smolyak sparse grid and a product polynomial basis
- `smol_H` constructs a Smolyak grid of dimension d with "fineness" mu. See Malin, Krueger, and Kubler (2011) "[Solving the multi-country real business cycle model using a Smolyak-collocation method](https://www.sciencedirect.com/science/article/pii/S0165188910002198)", Journal of Economic Dynamics & Control, for details;
- `smol_pol` creates a k-by-d matrix of optimal product polynomial degrees defining a Smolyak interpolant, where k is the number of polynomials which equals the number of Smolyak grid points;
- `smol_ind` and `smol_m` are auxiliary functions.
