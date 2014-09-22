Coord = dlmread('CoordSt.csv');
Coord(72,:) = [];
dataset = dlmread('out_30.txt');
dataset = dataset(:,1:51);
dataset(find(dataset(:,3)==30071),:)=[];

Dist = squareform(pdist(Coord(:,1:2)));
X = Coord(:,1);Y = Coord(:,2);
%%

days = unique(dataset(:,1));
scores = [];
length(days)
for i = 1:length(days)
    tic
    [scores(:,i), Avg, theDay] = getWeights2Types(dataset, days(i));
    %[~, ~, scores(:,i), avg, theDayData] = getWeightsParts_Bar(dataset, days(i));
    i
    toc
end
scoreMean = mean(scores);
[sMean, iMean] = sort(scoreMean, 'descend');
save('Minn.mat')
%%
sc = scores(:,94);
figure;scatter(X, Y ,30*(sc+0.1), sc,'filled','MarkerEdgeColor','k')
