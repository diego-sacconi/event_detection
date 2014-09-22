function [scores] = plantEvent(X, Y, mask)
    
    N = 1000;
    n = round(sqrt(N));
    mask = imresize(mask, [n,n]);
    mask = double(mask);

    [n, m, ~] = size(mask);
    [X_art,Y_art] = meshgrid(linspace(min(X),max(X),n), linspace(min(Y),max(Y),m));

    Z = mask(:,:,1);
    Z = Z - min(Z(:));
    Z = Z./max(Z(:));

    tree = kdtree_build( [X_art(:), Y_art(:)] );
    gridIDX = kdtree_nearest_neighbor(tree, [X Y]);
    kdtree_delete(tree);
    Z = Z(:);
    scores = Z(gridIDX);
    scores = scores/max(scores);
end

