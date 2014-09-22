Coord = dlmread('CoordSt.csv');
%Coord([77, 245, 383, 399, 403, 417, 422], :) = [];
dataset = dlmread('allWithAvgAddInf_matlab.csv');
dataset(find(dataset(:,3) == 394),:) = [];
Dist = squareform(pdist(Coord(:,1:2)));
X = Coord(:,1);Y = Coord(:,2);
%%

days = unique(dataset(:,1));
scores = [];
length(days)
for i = 1:length(days)
    tic
    [~, ~, scores(:,i), avg, theDayData] = getWeightsParts_Bar(dataset, days(i));
    i
    toc
end
scoreMean = mean(scores);
[sMean, iMean] = sort(scoreMean, 'descend');
save('Barcelona.mat')
%%
sc = scores3(:,iMean(20));
figure;scatter(X, Y ,30*sc, sc,'filled','MarkerEdgeColor','k')
