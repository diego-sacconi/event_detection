Coord = dlmread('CoordSt.csv');
%Coord([62],:) = [];
dataset = dlmread('out_490st.txt');
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


scoreMean = mean(scores);
[sMean, iMean] = sort(scoreMean, 'descend');
save('LA.mat')
%%
sc = scores(:,iMean(100));
figure;scatter(X, Y ,10*(sc+0.1), sc,'filled','MarkerEdgeColor','k')
