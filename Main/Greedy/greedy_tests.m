function [vert,curObj] = greedy_tests(par, scores, Dist, root, a)    
    n = length(scores);
    vert = zeros(n,1);
    vert(root) = 1;
    [curObj] = calcObject(par, scores, Dist, vert, root, a);
    [newObj, bestInd] = add(par, scores, Dist, vert, root,a);    
    while (newObj >= curObj)    
        vert(bestInd) = 1;
        curObj = newObj;
        [newObj, bestInd] = add(par, scores, Dist, vert,root, a); 
    end    
end

function [bestVal, bestInd] = add(par, scores, Dist, vert,root, a) 
    free = find(vert==0);
    bestVal = -intmax; bestInd = -1;
    for i = free'
        v = vert;
        v(i) = 1;
        [objval] = calcObject(par, scores, Dist, v, root, a);
        if objval > bestVal
            bestVal = objval;
            bestInd = i;
        end
    end
end

function[objval] = calcObject(par, scores, Dist, vert, root, a)
    objval = -intmax;
    taken = find(vert==1);
    r = find(taken==root);
    if par == 1
        d = sum(sum(Dist(taken,taken)))/2;
%         if d == 0
%             d = 1;
%         end
        s = sum(scores(taken));
        objval = s/sqrt(d + a);
    elseif par == 2
        [Tree, ~] = graphminspantree(sparse(Dist(taken,taken)), r);
        d = sum(Tree(:));
        s = sum(scores(taken));
        objval = s/(a+d);
    elseif par == 3
        d = sum(sum(Dist(taken,taken)))/2;       
        s = sum(scores(taken));
        objval = a*s - sqrt(d);
    end
end