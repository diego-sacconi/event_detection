function[Edges, Vertices] = init(scores, Dist, rootId)
    n = length(scores);

    Edges = struct('deficit', nan, 'active', nan, 'order', nan);
    Edges.deficit = Dist;
    %Edges.active = 2*ones(n,n);
    Edges.active = zeros(n,n);
    existsEdg = logical(Edges.deficit);
    Edges.active(existsEdg) = 2;
    Edges.active(rootId,:) = logical(Edges.active(rootId,:));
    Edges.active(:,rootId) = logical(Edges.active(rootId,:));
    Edges.active(logical(eye(n))) = 0;
    Edges.active = sparse(Edges.active);
    Edges.order = sparse(zeros(n, n));
    
    Edges.active = Edges.active;
    Edges.order = zeros(n, n);

    Vertices = struct('potential', nan, 'compName', nan, 'active', nan, 'order', nan);
    Vertices.potential  = scores;
    Vertices.active = ones(n,1);
    Vertices.active(rootId) = 0;
    Vertices.compName = (1:n)';
    Vertices.order = zeros(n, 1);
end