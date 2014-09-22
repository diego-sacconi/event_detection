function [X, objval] = solveSDPMaxCut(alpha, scores, Dist)
    s = length(scores);
    B = zeros (s+2,s+2);

    B(2:(end-1),1) = 2*alpha*scores;
    B(1,2:(end-1)) = 2*alpha*scores';

    t = sum(Dist,1);
    B(2:(end-1),end) = t;
    B(end,2:(end-1)) = t';

    B(2:(end-1),2:(end-1)) = Dist;

    % solver
    n = length(B); e = ones(n,1);
    C{1,1} = -(spdiags(B*e,0,n,n)-B)/4;
    b = e;
    blk{1,1} = 's';  blk{1,2} = n;

    A = cell(1,n);
    for k = 1:n; A{k} = sparse(k,k,1,n,n); end;
    At(1,1) = svec(blk,A,ones(size(blk,1),1));

    %
    blk{2,1} = 'u'; blk{2,2} = 1;
    n2 = n*(n+1)/2;
    zz = sparse(n2-n+1, 1, 1, n2, 1);
    %At{2,1} = [At{1} zz];
    At{2,1} = sparse([1, zeros(1,n2)]); 

    C{2,1} = 1; 
    %blk{1,2} = n+1;
    b = [b;-1];

    %blk{2,1} = 'u'; blk{2,2} = 1;
    %n2 = n*(n+1)/2; zz = sparse(n2,1); zz(1) = 1;
    %At{2,1} = [1, zz'];
    %At{2,1} = zz;
    %b = [b; 1];

    [obj,X,~,~] = sqlp(blk, At, C, b);
    objval = obj(1);
end

