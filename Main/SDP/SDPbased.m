function [ResOut, bestCost, w, dist] = SDPbased(runs, alpha, scores, Dist, par)
   
    bestCost = -intmax;
    if par == 1
        %[X__, objval] = solveSDP(alpha, scores, Dist);
        [X__] = solveSDPSedumi(alpha, scores, Dist);
    elseif par == 2
        %[X__, objval] = solveSDPMaxCut(alpha, scores, Dist);
        [X__] = solveSDPSedumiMaxCut(alpha, scores, Dist);
    end
    V = chol(X__,'lower');

    n = length(V);

    for i = 1:runs        
        r = randn(1,n);
        Res = sign(diag(V*repmat(r',1,n)));

        [cost] = getObjValue(Res, Dist, scores,alpha, par);
                
        if (bestCost < cost)
            bestCost = cost;
            ResOut = Res;
        end 
    end  
    if par == 1
        ResOut = (ResOut == ResOut(1));
        ResOut = ResOut(2:end);
    elseif par == 2
        ResOut = (ResOut ~= ResOut(1));
        ResOut = ResOut(2:(end-1));
    end
    w = sum(scores(ResOut));
    dist = 0.5*(- sum(sum(Dist(ResOut,ResOut))) + sum(Dist(:)));
end

