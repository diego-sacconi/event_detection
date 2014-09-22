function [adj, prize, weight, dist, xx, yy, ss, outInd, SDPLikeCost] = do_not_complete(scUnw, alpha, Dist, root, X, Y)
    scores = scUnw*alpha;
    S = sum(scores);
    [Edges, Vertices] = init_(scores, Dist, root);
    dt = max(sum(scores), sum(Dist(:)/2))+1;
    Edges.deficit(logical(eye(size(Edges.active,1)))) = dt;
    
    while (sum(Vertices.active == 1) > 0)        
        [Edges, Vertices, onEdg, idx] = reduceSeq(Edges, Vertices, root, X, Y);       
    end
    
    nonZer = (sum(Edges.order)~=0);
    %wgPlot(Edges.order(nonZer,nonZer), [X(nonZer) Y(nonZer)], 'vertexWeight', scores(nonZer),'vertexMetadata',(1:sum(nonZer))','edgeWidth',1);
    
    outComp = find(Vertices.compName == Vertices.compName(root));
    %figure; scatter(X,Y,scores*10,'fill');
    %hold on;    
    %wgPlot(Edges.order(outComp,outComp), [X(outComp) Y(outComp)], 'vertexWeight', scores(outComp),'vertexMetadata',(1:length(outComp)));
    
    
    [Adj, prizes] = prune(Edges.order(outComp,outComp), scores(outComp), Dist(outComp,outComp), find(outComp == root));
    
    
    %figure; scatter(X,Y,scores*10,'fill');
    x = X(outComp); y = Y(outComp);
    %hold on; 
    nonZer = (sum(Adj)~=0);
    %wgPlot(Adj(nonZer,nonZer), [x(nonZer) y(nonZer)], 'vertexWeight', prizes(nonZer),'vertexMetadata',(1:sum(nonZer))');
    
    d = Dist(outComp,outComp); d = d(nonZer,nonZer);
    s = scUnw(outComp); s = s(nonZer);
    adj = Adj(nonZer,nonZer);
    [prize, weight, dist, SDPLikeCost]  = getPrize(adj, d, s, S, alpha);
    
    xx = x(nonZer); yy = y(nonZer); ss = s; 
    outInd = outComp(nonZer);
    if (weight == 0)
        weight = scUnw(root);
    end
end


