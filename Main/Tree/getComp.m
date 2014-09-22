function[am, prize, w, d, x ,y, s, oi, bestR, SDPLikeC] = getComp(roots, alpha, tDist,scores, X,Y)
    pr = intmax; bestR = 0;    

    for i = roots'
        [adj, prize, ww, dd, xx ,yy, ss, outInd, SDPLikeCost] = do_not_complete(scores, alpha, tDist, i, X, Y);        
        if prize < pr
            pr = prize;
            bestR = i;
            x = xx; y = yy; s = ss; am = -adj; w = ww; oi = outInd;  
            SDPLikeC = SDPLikeCost; d = dd;
        end
        %prizeArr(i) = prize;
    end
end

