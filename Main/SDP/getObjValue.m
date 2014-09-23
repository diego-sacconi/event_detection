function [obj] = getObjValue(X, D, W, alpha,par)
     
    if (par == 1)
        ind = find(X(2:end) == X(1));
        ind_ = find(X(2:end) ~= X(1));
        t1 = sum(W(ind));
        t2 = sum(sum(D(ind_,ind_)))/2;
        t3 = sum(sum(D(ind,ind_)));
        %t4 = sum(sum(D(ind,ind)))/2;
        obj = alpha*t1 + t2 + t3;
        %obj = alpha*t1 - t4/2;
    elseif par == 2
        %ind = find(X == 1);
        %ind_ = find(X ~= 1);
        ind = (X == 1);
        ind_ = ~ind;
        scores = W;
        dist = D;
        s = length(scores);
        B = zeros (s+2,s+2);

        B(2:(end-1),1) = 2*alpha*scores;
        B(1,2:(end-1)) = 2*alpha*scores';

        t = sum(dist,1);
        B(2:(end-1),end) = t;
        B(end,2:(end-1)) = t';

        B(2:(end-1),2:(end-1)) = dist;    
        
        obj = sum(sum(B(ind,ind_)))/2;
    end
end

