% test for generated data

aRangeAP = 0:10:200;
%aRangeAP = 0:10:20;
aRangeTree = 0:0.02:0.2;
SDPruns = 1000;

id = '1'; %one round cluster
%id = '2'; %two round cluters
%id = '9'; %curve cluster

noise = 0.8;

fname = [ '..\\Datasets\\Generated\\' char(id) '_' num2str(noise*100) 'add.mat'];
load(fname);
Y = Y_d;
X = X_d;
sc = distorted/max(distorted);
Dist = squareform(pdist([X Y]));
Dist = Dist/max(Dist(:));
root = getRoots(sc,1);

accuracyAP = zeros(length(aRangeAP),3);

for i = 1:length(aRangeAP)   
    a = aRangeAP(i);
    [resGreedyAP, costGreedyAP, weightGreedyAP, distGreedyAP] = greedy(1, sc, Dist, root, a);
    [resBNFS, costBNFS, weightBNFS, distBNFS] = GreedyDual(sc, Dist, a);
    [resSDP, costSDP, weightSDP, distSDP] = SDPbased(SDPruns, a, sc, Dist, 2);    
   
    accuracyAP(i,1) = accuracy(resGreedyAP, a, scores);
    accuracyAP(i,2) = accuracy(resBNFS, a, scores);
    accuracyAP(i,3) = accuracy(resSDP, a, scores);

end

plot(aRangeAP, accuracyAP(:,1),'--k');
hold on;
plot(aRangeAP, accuracyAP(:,2),'r');
hold on;
plot(aRangeAP, accuracyAP(:,3),'-.g');
legend('GreedyAP','BFNS', 'SDP','pos',4);
xlabel('weight multiplier');
title('accuracy'); 
%%

