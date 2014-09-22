function[val, onEdg, idx] = getValue(Edges, Vertices)
    actI = find(Vertices.active);
    %[compMin, compIdx] = min(Vertices.potential(actI) - dt*Vertices.active(actI));
    [compMin, compIdx] = min(Vertices.potential(actI));
    compIdx = actI(compIdx);
    actI = find(Edges.active > 0);
    %[edgMin, edgIdx] = min(Edges.deficit(actI)./Edges.active(actI) - dt*logical(Edges.active(actI)));
    [edgMin, edgIdx] = min(Edges.deficit(actI)./Edges.active(actI));
    edgIdx = actI(edgIdx);
    onEdg = 0;
    if (edgMin < compMin)
        val = Edges.deficit(edgIdx)/Edges.active(edgIdx);
        onEdg = 1;
        idx = edgIdx;
    else
        val = Vertices.potential(compIdx);
        idx = compIdx;
    end
end