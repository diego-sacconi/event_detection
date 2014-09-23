function [takenNodes, cost, w, dist] = greedy(par, scores, Dist, root, a)    
    vert = (1:length(scores))';    
    spanningTreeCost = 0;
    [ind, val] = add(par,scores, Dist, root, vert, a);
    while (val > 0)
        vert(ind) = root;
        [ind, val, edgeCost] = add(par,scores, Dist, root, vert, a);
        spanningTreeCost = spanningTreeCost + edgeCost;
    end
    takenNodes = (vert==root);
    
    
    if par == 1
        w = sum(scores(takenNodes));
        dist = 0.5*(-sum(sum(Dist(takenNodes,takenNodes))) + sum(Dist(:)));
        cost = a*w + dist;
    else
        w = sum(scores(~takenNodes));
        dist = spanningTreeCost;
        cost = a*w + dist;
    end    
end

function [ind, val, edgeCost] = add(par, scores, Dist, root, vert, a)
    edgeCost = 0;
    free = find(vert ~= root);
    taken = find(vert == root);
    if par == 1
        [val, i] = max(a.*scores(free) - sum(Dist(free, taken),2));
        %[val, i] = max(a.*scores(free) - sum(Dist(free, taken),2));
        %[val, i] = max(scores(free)./sum(Dist(free,taken),2));
    else
        [val, i] = max(a.*scores(free) - min(Dist(free, taken),[],2));
        edgeCost = min(Dist(i, taken),[],2);
        if isempty(edgeCost)
            edgeCost = 0;
        end
    end
    ind = free(i);
end
