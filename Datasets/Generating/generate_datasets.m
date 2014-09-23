datasets = {'../Twitter/NY/CoordSt.txt';...
    %'../Twitter/LA_big/CoordSt.txt';...
    %'../Bikes/WDC/CoordSt.txt';...
    %'../Bikes/Minn/CoordSt.txt';...
    '../Bikes/Barcelona/CoordSt.txt'};

masks = {%'./art_clusters/2ovals1.png';...   
    %'./art_clusters/2oval1_grads.png';...
    %'./art_clusters/curve.png'...
    %'./art_clusters/curve1.png';...
    %'./art_clusters/cross.png';...
    %'./art_clusters/star.png';...
    %'./art_clusters/bubbles.png';...
    %'./art_clusters/circular.png';...
    './art_clusters/round.png';...
    %'./art_clusters/big_circular.png'...
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
       
        X_d = X; Y_d = Y;
        save(['./generated_add/' num2str(mi) '_' num2str(nlevel*100) 'add'])
        
        %figure; scatter(X,Y,100*(scores+0.1), 100*(scores+0.1),'filled')
    end
end
