function[oi, prize, weight, d] = runPCST(roots, alpha, tDist, scores, X,Y)
    pr = intmax; bestR = 0;
    
    for i = roots'
        [adj, prize, ww, dd, xx ,yy, ss, outInd, SDPLikeCost] = do_not_complete(scores, alpha, tDist, i, X, Y);        
        if prize < pr
            pr = prize;
            bestR = i;
            w = ww; oi = outInd;  
            d = dd;
        end
    end
    weight = sum(scores) - w;
end

