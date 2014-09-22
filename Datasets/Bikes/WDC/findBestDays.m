Coord = dlmread('CoordSt.csv');
%Coord([62],:) = [];
dataset = dlmread('out_30.txt');
dataset = dataset(:,1:51);
%dataset(find(dataset(:,3)==31301),:)=[];
%dataset(find(dataset(:,3)==31069),:)=[];
%dataset(find(dataset(:,3)==31068),:)=[];

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
%%
scores(62,:) = [];
scores(end,:) = [];

Dist(62,:) = []; Dist(:,62) = []; 
X(62) = []; Y(62) = [];

Dist = Dist(1:(end-1),1:(end-1)); 
X(end) = []; Y(end) = [];

scoreMean = mean(scores);
[sMean, iMean] = sort(scoreMean, 'descend');
save('WDC.mat')
%%
sc = scores(:,42);
figure;scatter(X, Y ,10*(sc+0.1), sc,'filled','MarkerEdgeColor','k')
