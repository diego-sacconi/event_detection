load('..\\Datasets\\Bikes\\Barcelona\\Barcelona.mat')
%%
Y = Coord(:,2);
X = Coord(:,1);

day = 149; %11.09.2012
scores = scores(:,day);
scores = scores/max(scores);
Dist = Dist/max(Dist(:));
root = getRoots(scores,1);

aRangeAP = 0:10:200;
aRangeTree = 0:0.02:0.2;
aRangeTree = 0:0.02:0.03;
SDPruns = 1000;

%% 
%% Run Algorithms for All-Pairs distance model

costAP = zeros(size(aRangeAP,1),4);
for i = 1:size(aRangeAP,2)
    a = aRangeAP(i);
    [resGreedyAP, costGreedyAP, weightGreedyAP, distGreedyAP] = greedy(1, scores, Dist, root, a);
    [resBNFS, costBNFS, weightBNFS, distBNFS] = GreedyDual(scores, Dist, a);
    [resSDP, costSDP, weightSDP, distSDP] = SDPbased(runs, a, scores, Dist, 2);    
    [resTrivial, costTrivial, weightTrivial, distTrivial] = trivial(scores, Dist, a); 
    costAP(i,:) = [costGreedyAP, costBNFS, costSDP, costTrivial];
end

%set(gca,'FontSize',23);
%set(0,'defaultlinelinewidth',2);
    
plot(aRangeAP, costAP(:,1),'--k');
hold on;
plot(aRangeAP, costAP(:,2),'r');
hold on;           
plot(aRangeAP, costAP(:,3),'-.g');
hold on;
plot(aRangeAP, costAP(:,4),':b')
    
legend('GreedyAP', 'BFNS','SDP', 'Trivial','pos', 2);
xlabel('weight multiplier');
ylabel('cost');
title('cost function value');  

%%
%% Run Algorithms for Tree distance model

costTree = zeros(size(aRangeTree,1),2);
for i = 1:size(aRangeTree,2)
    a = aRangeTree(i);
    [resGreedyT, costGreedyT, weightGreedyT, distGreedyT] = greedy(2, scores, Dist, root, a);
    [taken, costPD, weightPD, distPD] = runPCST(root, a, Dist, scores, X, Y);
    costTree(i,:) = [costGreedyT, costPD];
end

plot(aRangeTree, costTree(:,1),'--k');
hold on;
plot(aRangeTree, costTree(:,2),'r');
legend('GreedyT', 'PD','pos',4);
xlabel('weight multiplier');
ylabel('cost');
title('cost function value');

