function [vert, sumEdgeCost] = growGreedy_costGain(par, scores, Dist, root, a)    
    vert = (1:length(scores))';
    %d = sum(sum(Dist(vert == root,vert == root)));
    %w = sum(scores(vert == root));
    %while (w < threshold)
    sumEdgeCost = 0;
    [ind, val] = add(par,scores, Dist, root, vert, a);
    while (val > 0)
    %for k = 1:1000    
        vert(ind) = root;
        [ind, val, edgeCost] = add(par,scores, Dist, root, vert, a);
        sumEdgeCost = sumEdgeCost + edgeCost;
        %w = sum(scores(vert == root));
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
