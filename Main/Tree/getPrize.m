function[prize, weight, dist, SDPLikeCost] = getPrize(Edges, Dist, scUnw, SWeigh, alpha) 
    scores = scUnw*alpha;
    t = triu(Edges);
    d = sum(sum(Dist(logical(t))));    
    w = sum(scores);
    prize = - w + d + SWeigh; %dist in + scores out
    SDPLikeCost = w - d;
    weight = sum(scUnw);
    dist = d;
end