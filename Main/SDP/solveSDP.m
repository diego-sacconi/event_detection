function [X, objval] = solveSDP(alpha, scores, Dist)
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

    B = -(alpha*W-D)./4;
    %%B = -(alpha*W-D); 

    % solver
    n = length(B);
    C{1} = B; 
    b = ones(n,1);
    blk{1,1} = 's';  blk{1,2} = n;

    A = cell(1,n);
    for k = 1:n; A{k} = sparse(k,k,1,n,n); end; 
    Avec = svec(blk,A,ones(size(blk,1),1));
    %[X0,y0,Z0] = infeaspt(blk,Avec,C,b); 
    %y0 = -1.1*abs(C{1})*ones(n,1);
    %Z0{1} = C{1} - spdiags(y0,0,n,n);
    %X0{1} = spdiags(b,0,n,n); 
    
    %[obj,X,y,Z] = sqlp(blk,Avec,C,b,[],X0,y0,Z0);
    [obj,X,~,~] = sqlp(blk,Avec,C,b);
    objval = obj(1);
end

