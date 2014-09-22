datasets = {'../Datasets/Twitter/NY_small/CoordSt.csv';...
    %'../Datasets/Twitter/LA_big/CoordSt.csv';...
    %'../Datasets/Bikes/WDC/CoordSt.csv';...
    %'../Datasets/Bikes/Minn/CoordSt.csv';...
    '../Datasets/Bikes/Barcelona/CoordSt.csv'};

masks = {%'../RunTest/art_clusters/2ovals1.png';...   
    %'../RunTest/art_clusters/2oval1_grads.png';...
    %'../RunTest/art_clusters/curve.png'...
    %'../RunTest/art_clusters/curve1.png';...
    %'../RunTest/art_clusters/cross.png';...
    %'../RunTest/art_clusters/star.png';...
    %'../RunTest/art_clusters/bubbles.png';...
    %'../RunTest/art_clusters/circular.png';...
    '../RunTest/art_clusters/round.png';...
    %'../RunTest/art_clusters/big_circular.png'...
    };

noise = 0:0.05:0.99;
%%

for dsi = 1:size(datasets,1)
    ds = datasets{dsi};
    Coord = dlmread(ds);
    X = Coord(:,1); Y = Coord(:,2);
    for mi = 1:size(masks,1)
        msk = masks{mi};
        mask = imcomplement(imread(msk));
        [scores] = plantEvent(X, Y, mask);
        for nlevel = noise
            [distorted] = addNoise(scores, nlevel);
            %[distorted, X_d, Y_d, disable] = deleteSt(scores, X, Y, nlevel);
            X_d = X; Y_d = Y;
            save(['./planted_add/' num2str(dsi) '_' num2str(mi) '_' num2str(nlevel*100) 'add'])
            %figure; scatter(X,Y,100*(scores+0.1), 100*(scores+0.1),'filled')
        end
    end
end
%%
N = 400;
for mi = 1:size(masks,1)
    msk = masks{mi};
    mask = imcomplement(imread(msk));
    [X,Y,scores] = generate(mask, N);
    for nlevel = noise
        [distorted] = addNoise(scores, nlevel);
        %[distorted, X_d, Y_d, disable] = deleteSt(scores, X, Y, nlevel);
        X_d = X; Y_d = Y;
        %save(['./generated_add_more/' num2str(mi) '_' num2str(nlevel*100) 'add'])
        save(['./generated_add_more/'  '9_' num2str(nlevel*100) 'add'])
        %figure; scatter(X,Y,100*(scores+0.1), 100*(scores+0.1),'filled')
    end
end

%%

%N = 0:50000:1000001;
 msk = '../RunTest/art_clusters/bubbles.png';
 mask = imcomplement(imread(msk));
 n = 10000:10000:100001;
for N = n      
        [X,Y,scores] = generate(mask, N);
        [distorted] = addNoise(scores, 0.2);
        save(['./generated/' num2str(N)])
end
%%
t=[];
n = 0:50000:1000001;
l = length(n(2:end));
for i = 1:l
    N = n(i+1);
    load(['./generated/' num2str(N)])
    tic
    root = getRoots(distorted, 1);
    [vert] = greedy2(distorted, X, Y, 10000, root);
    t(i) = toc; 
end
save('out.mat',t,n);