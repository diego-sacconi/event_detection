function [outVert, outF] = subMod_half(scores, Dist, alpha, runs)
    n = length(scores);    
    outF = -intmax;
    outVert = zeros(n,1);
    
    for runs = 1:runs    
        vert = zeros(n,1);
        vert_ = ones(n,1);
        order = randperm(n);

        for i = order
            f = getObjValue(vert, Dist, scores, alpha);
            f_ = getObjValue(vert_, Dist, scores, alpha);
            t = vert; t_ = vert_;
            t(i) = 1; t_(i) = 0;
            newF = getObjValue(t, Dist, scores, alpha);
            a = max(newF - f, 0);
            newF_ = getObjValue(t_, Dist, scores, alpha);
            b = max(newF_ - f_, 0);
            if a == b && a == 0
                p = 1;
            else
                p = a/(a + b);
            end
            r = rand;

            if r < p
                vert = t;
            else
                vert_ = t_;
            end           

        end
        f = getObjValue(vert, Dist, scores, alpha);
        
        if (f > outF)
            outF = f;
            outVert = vert;
        end
    end
end

function [obj] = getObjValue(vert, D, W, alpha)
    ind = logical(vert);
    ind_ = logical(~vert);
    t1 = sum(W(ind));
    t2 = sum(sum(D(ind_,ind_)));
    t3 = sum(sum(D(ind,ind_)));
    t4 = sum(sum(D(ind,ind)));
    %obj = alpha*t1 + t2/2 + t3/2;
    obj = alpha*t1 - t4/2;
end

