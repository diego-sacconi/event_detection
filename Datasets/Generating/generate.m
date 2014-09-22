function [X,Y,scores] = generate(mask, N)    
    n = round(sqrt(N));
    mask = imresize(mask, [n,n]);
    mask = double(mask);

    [n, m, ~] = size(mask);
    [X,Y] = meshgrid(1:1:m, 1:1:n);

    Z = mask(:,:,1);
    Z = Z - min(Z(:));
    Z = Z./max(Z(:));

    scores = Z(:);    
    p = 0.9;
    noise = -p+2*p.*rand(n,m,1);
    X = X + noise;
    noise = -p+2*p.*rand(n,m,1);
    Y = Y + noise;
    X = X(:); Y = Y(:);
end

