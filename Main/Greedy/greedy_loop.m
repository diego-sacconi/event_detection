function [vert] = greedy_loop(scores, X, Y, alpha, root)
    n = length(scores);
    vert = zeros(n,1);
    vert(root) = 1;
    [val, ind] = diff(vert, X, Y, scores, alpha);
    K = 1000;
    for i = 1:K
        vert(ind) = 1;
        [val, ind] = diff(vert, X, Y, scores, alpha);    
    end
end

function [bestVal, outVert] = diff(vert, X, Y, W, alpha)
    ind = find(vert == 1); 
    ind_ = find(vert == 0); 
    bestVal = -intmax;
	outVert = ind_(1);
    for v = ind_'
        w = alpha*W(v); x = X(v); y = Y(v);
        d = 0;
        for i = ind'
            d = d + sqrt((x - X(i))^2 + (y - Y(i))^2);
        end
        out = w - d;
        if out > bestVal
            bestVal = out;
            outVert = v;
        end
    end    
end

