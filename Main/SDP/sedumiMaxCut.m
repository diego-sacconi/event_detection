n=60;
% Generate a weighted graph
W=sprandsym(n,.5); W(1:n+1:n^2)=zeros(1,n);
% Calculate the Laplacian
L=1/4 * (diag(W*ones(n,1))-W);

c=-L(:); % Format the Laplacian to vector form
% Translate constraint diag(X)=e into vector format:
A = sparse(1:n,1:n+1:n^2,ones(1,n),n,n^2);

t1 = sparse(1,n*n);
t1(n) = 1;
t2 = sparse(1,n*n);
t2(n*n-n+1) = 1;

A = [A; t1; t2];


b = ones(n,1);
b = [b; -1; -1];
% Tell SeDumi that X must be positive semidefinite
K.s = [n];
[X,Y,INFO] = sedumi(A,b,c,K); % Run SeDumi

