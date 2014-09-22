
%%
[Coord, dataset, Dist] = loadInput();
theDay = 149;
%[scores1, scores2, scores3, avg, theDayData] = getWeightsParts(dataset, 149);
[scores1, scores2, scores3, avg, theDayData] = getWeight(dataset, 149);
%[scores, Avg, theDay] = getWeights2Types(dataset, 43);%% 149 - best day; 214 - worst day
Y = Coord(:,1);
X = Coord(:,2);

scores = scores/max(scores);
Dist = Dist/max(Dist(:));

aRangeSum = 0:10:200;
aRangeTree = 0:0.02:0.2;
root = getRoots(scores,1);
%% run Geedy Sum
aRange = aRangeSum;
ResGrSum = []; costGrSum = []; %cost_GrSum_shift = [];
wGrSum = []; dGrSum = [];
for i = 1:length(aRange)
    tic
    [res] = growGreedy_costGain(1, scores, Dist, root, aRange(i));
    free = find(res ~= root);
    taken = find(res == root);
    wGrSum(i) = sum(scores(taken));
    dGrSum(i) = sum(sum(Dist(taken, taken),2))/2;
    costGrSum(i) = wGrSum(i)*aRange(i) - dGrSum(i);
    %cost_GrSum_shift(i) = costGrSum(i) + sum(Dist(:))/2;
    ResGrSum(:,i) = (res == root);
    toc
end
%save([num2str(theDay) 'GrSum_10_200'])

%% run Greedy Tree
aRange = aRangeTree;
ResGrMin = []; costGrMin = []; %cost_GrMin_shift = [];
wGrMin = []; dGrMin = [];

for i = 1:length(aRange)    
    [res, edgesCost] = growGreedy_costGain(2, scores, Dist, root, aRange(i));
    free = find(res ~= root);
    taken = find(res == root);
    %costGrMin(i) = sum(scores(taken)) - sum(sum(Dist(taken, taken),2))/2;
    wGrMin(i) = sum(scores(taken));
    dGrMin(i) = edgesCost;
    costGrMin(i) = wGrMin(i).*aRange(i) - dGrMin(i);
    %cost_GrMin_shift(i) = costGrMin(/i) + sum(Dist(:))/2;
    ResGrMin(:,i) = (res == root);
end

save([num2str(theDay) 'GrMin_002_02'])

%% run SDP
runs = 500;
aRange = aRangeSum;
ResSDP = []; costSDP = [];
wSDP = []; dSDP = [];
for i = 1:length(aRange)
    [res, ~, inWeight, ~, ~, inDist] = runNTimes(runs, aRange(i), scores, Dist);
    
    free = find(res(2:end) ~= res(1));
    taken = find(res(2:end) == res(1));
    
    wSDP(i) = sum(scores(taken));
    dSDP(i) = sum(sum(Dist(taken, taken)))/2;
    costSDP(i) = wSDP(i)*aRange(i) - dSDP(i);    
    ResSDP(:,i) = (res(2:end)==res(1)); 
end

%save([num2str(theDay) 'SDP_10_200']);
%% run Tree
aRange = aRangeTree;
wTree = []; dTree = [];
ResTree = []; costTree = [];
for i = 1:length(aRange)
    [am, ~, w, d, x ,y, ~, outInd, ~, SDPLikeCost] = getComp(root, aRange(i), Dist, scores, X, Y);
    costTree(i) = SDPLikeCost;
    wTree(i) = w; dTree(i) = d;
    ts = zeros(420,1); ts(outInd) = 1;
    ResTree(:,i) = ts;
end

save([num2str(theDay) 'Tree_002_02'])
%% run rounding
aRange = 0:0.001:5;
%aRange = 0

ev = eig(Dist);
lambda = abs(ev(1));
%lambda = 0;
shift = eye(size(Dist))*lambda;
DistShifted = Dist + shift;

costClose = []; wClose = []; dClose = []; ResClose = [];
e = eye(size(Dist));
for i = 1:length(aRange)
    DistShifted =  DistShifted + e*aRange(i);
    x = 0.5*inv(DistShifted)*scores;
    [idx,c] = kmeans(x,2);
    tp1 = (idx == idx(1));
    tp2 = (idx ~= idx(1));
    c1 = sum(scores(tp1)) - sum(sum(Dist(tp1,tp1)))/2;
    c2 = sum(scores(tp2)) - sum(sum(Dist(tp2,tp2)))/2;
    if (c1 > c2)
        costClose(i) = c1;
        wClose(i) = sum(scores(tp1));
        dClose(i) = sum(sum(Dist(tp1,tp1)))/2;
        ResClose(:,i) = tp1;
    else
        costClose(i) = c2;
        wClose(i) = sum(scores(tp2));
        dClose(i) = sum(sum(Dist(tp2,tp2)))/2;
        ResClose(:,i) = tp2;
    end
end

save('149Close');


%% run opt
%% plot
scatter(X(:), Y(:), 50, ResTree(:,end), 'filled','MarkerEdgeColor', 'k');
%%
figure; scatter(X, Y, scores*30, scores, 'filled', 'MarkerEdgeColor', 'k');
hold on;
wgPlot(am, [x y], 'vertexWeight', ones(size(x)), 'edgeWidth', 1.5, 'edgeColorMap', hot)
