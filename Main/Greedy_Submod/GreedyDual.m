function [vert] = GreedyDual(scores, Dist, a)    
    vert = zeros(length(scores),1);    
    [ind, val] = add(scores, Dist, vert, a);
    while (val >= 0)
        vert(ind) = 1;
        [ind, val] = add(scores, Dist, vert, a);        
    end    
end

function [ind, val_real] = add(scores, Dist, vert, a)
    free = find(vert == 0);
    taken = find(vert == 1);
    [val, i] = max(a.*scores(free) - sum(Dist(free, taken),2) - 0.5*sum(Dist(free, free),2));
    ind = free(i);
    val_real = a.*scores(ind) - sum(Dist(ind, taken),2);    
end
