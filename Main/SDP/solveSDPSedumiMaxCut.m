function [X] = solveSDPSedumiMaxCut(alpha, scores, Dist)
    s = length(scores);
    B = zeros (s+2,s+2);

    B(2:(end-1),1) = alpha*scores;
    B(1,2:(end-1)) = alpha*scores';

    t = sum(Dist,1)/2;
    B(2:(end-1),end) = t;
    B(end,2:(end-1)) = t';

    B(2:(end-1),2:(end-1)) = Dist/2;
    n = length(B);

    L = 1/4 * (diag(B*ones(n,1))-B);

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
    [X,~,INFO] = sedumi(A,b,c,K); % Run SeDumi
    X = reshape(X,n,n);
end

