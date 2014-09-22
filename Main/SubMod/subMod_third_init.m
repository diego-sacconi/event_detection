function [vert, f] = subMod_third(scores, Dist, alpha, vert)
    n = length(scores);
    vert = zeros(n,1);
    vert_ = ones(n,1);
    order = randperm(n);    
    
    for i = order
        f = getObjValue(vert, Dist, scores, alpha);
        f_ = getObjValue(vert_, Dist, scores, alpha);
        t = vert; t_ = vert_;
        t(i) = 1; t_(i) = 0;
        newF = getObjValue(t, Dist, scores, alpha);
        a = newF - f;
        newF_ = getObjValue(t_, Dist, scores, alpha);
        b = newF_ - f_;
        if (a >= b)
            vert = t;
        else
            vert_ = t_;
        end            
    end
    f = getObjValue(vert, Dist, scores, alpha);
end

function [obj] = getObjValue(vert, D, W, alpha)
    ind = logical(vert);
    ind_ = logical(~vert);
    t1 = sum(W(ind));
    t2 = sum(sum(D(ind_,ind_)));
    t3 = sum(sum(D(ind,ind_)));
    %t4 = sum(sum(D(ind,ind)));
    obj = alpha*t1 + t2 + t3;
end

