function[Adj] = remSubtr(Adj, r)
    children = find(Adj(r,:) ~= 0);
    for ch = children
        Adj(r, ch) = 0;
        Adj(ch, r) = 0;
        Adj = remSubtr(Adj, ch);
    end
end