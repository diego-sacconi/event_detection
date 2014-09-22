function [ResOut, bestCost, t1out, t2out, t3out, t4out] = runNTimesSedumi(runs, alpha,scores, Dist, par)
    %eps = 0.1;
    %alpha = 50;
    %alpha = 10;


    %runs = getRunNumber(N, eps);

    %runs = 3;
    %obj = zeros(runs,1);
    %objvalOut = zeros(runs,1);
    %Xout = zeros(runs,N+1);
    
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

        [cost, t1, t2, t3, t4] = getObjValue(Res, Dist, scores,alpha, par);
        %gain = alpha*t1-t4/2;
        
        if (bestCost < cost)
            bestCost = cost;
            t1out = t1;
            t2out = t2;
            t3out = t3;
            t4out = t4;
            ResOut = Res;
        end
        
        %obj(i) = cost;
        %objvalOut(i) = objval;
        %Xout(i,:) = Res;
    end  
    if par == 1
        ResOut = (ResOut == ResOut(1));
        ResOut = ResOut(2:end);
    elseif par == 2
        ResOut = (ResOut ~= ResOut(1));
        ResOut = ResOut(2:(end-1));
    end
    
end

