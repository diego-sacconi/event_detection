function[Adj, prizes] = prune(Adj, prizes, Dist, root)
    Adj(:,root) = min(Adj(:,root), -Adj(:,root));
    children = find(Adj(root,:) > 0);
    for ch = children
        [Adj, prizes] = prune(Adj, prizes, Dist, ch);
        if (Dist(root, ch) >= prizes(ch))
            Adj(root,ch) = 0;
            Adj(ch,root) = 0;
            [Adj] = remSubtr(Adj, ch);
        else
            prizes(root) = prizes(root) + prizes(ch) - Dist(root, ch);
        end
    end
end