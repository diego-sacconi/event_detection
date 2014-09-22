load('..\\Datasets\\Bikes\\Barcelona\\Barcelona.mat')
%%
Y = Coord(:,2);
X = Coord(:,1);

day = 149; %11.09.2012
scores = scores(:,day);
scores = scores/max(scores);
Dist = Dist/max(Dist(:));
root = getRoots(scores,1);
alphaAP = 20;
alphaT = 0.1;

%%
alg = 'GreedyAP';
[res] = growGreedy_costGain(1, scores, Dist, root, alphaAP);
%free = find(res ~= root);
taken = find(res == root);

%%
alg = 'SDP';
runs = 1000;
[res, ~, ~, ~, ~, ~] = runNTimesSedumi(runs,alphaAP, scores, Dist, 2);
%free = find(~res);
taken = find(res);


%%
alg = 'GreedyT';
[res, ~] = growGreedy_costGain(2, scores, Dist, root, alphaT);
%free = find(res ~= root);
taken = find(res == root);

%%
[~, ~, ~, ~, ~ ,~, ~, res, ~, ~] = getComp(root, alphaT, Dist, scores, X, Y);

taken = res;

%%
eps = 1e-16;
f = figure('Name',alg);
colormap(gray);

frontX = X(taken);
frontY = Y(taken);
frontSc = scores(taken);
    
%scatter(X, Y, 100*(scores),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
scatter(X, Y, 100*(scores+eps),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0 0 0]);
hold on;
scatter(frontX, frontY,100*(frontSc),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
axis off;    
plot_google_map();

%%

