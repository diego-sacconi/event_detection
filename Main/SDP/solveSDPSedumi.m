function [X] = solveSDPSedumi(alpha, scores, Dist)
    s = length(scores);
    W = zeros (s+1,s+1);
    W(2:end,1) = scores;
    W(1,2:end) = scores;
    W(2:end,2:end) = diag(scores);

    D = zeros(s+1,s+1);
    t = sum(Dist,1); 
    D(2:end,1) = t;
    D(1,2:end) = t;
    D(2:end,2:end) = Dist;

    L = (alpha*W-D)./4;
    n = length(W);
    
    c = -L(:); % Format the Laplacian to vector form
    % Translate constraint diag(X)=e into vector format:
    A=sparse(1:n,1:n+1:n^2,ones(1,n),n,n^2);
    b=ones(n,1);
    % Tell SeDumi that X must be positive semidefinite
    K.s = [n];
    [X,~,INFO] = sedumi(A,b,c,K); % Run SeDumi
    
    X = reshape(X,n,n);    
end

