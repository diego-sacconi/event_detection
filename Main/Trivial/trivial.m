function [res, cost, weight, dist] = trivial(scores, Dist, a)
    if (0.5*sum(Dist(:)) > sum(scores))
        res = zeros(size(scores));
        weight = 0;
        dist = 0.5*sum(Dist(:));    
    else
        res = ones(size(scores));
        weight = sum(scores);
        dist = 0; 
    end
    cost = a*weight + dist;
end

