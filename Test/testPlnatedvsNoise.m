% test for planted data

alphaAP = 20;
alphaTree = 0.1;
%aRangeTree = 0:0.02:0.03;
SDPruns = 1000;

noise = 0:0.05:0.51;
%noise = 0:0.05:0.1;
id = '1_1'; %planted NY dataset
%id = '2_2'; %planted Barcelona dataset

accuracyAP = zeros(length(noise),3);


for n = 1:length(noise)   
    fname = [ '..\\Datasets\\Planted\\' char(id) '_' num2str(noise(n)*100) 'add.mat'];
    load(fname);
    Y = Y_d;
    X = X_d;
    sc = distorted/max(distorted);
    Dist = squareform(pdist([X Y]));
    Dist = Dist/max(Dist(:));
    root = getRoots(sc,1);
    
    [resGreedyAP, costGreedyAP, weightGreedyAP, distGreedyAP] = greedy(1, sc, Dist, root, alphaAP);
    [resBNFS, costBNFS, weightBNFS, distBNFS] = GreedyDual(sc, Dist, alphaAP);
    [resSDP, costSDP, weightSDP, distSDP] = SDPbased(SDPruns, alphaAP, sc, Dist, 2);    
   
    accuracyAP(n,1) = accuracy(resGreedyAP, alphaAP, scores);
    accuracyAP(n,2) = accuracy(resBNFS, alphaAP, scores);
    accuracyAP(n,3) = accuracy(resSDP, alphaAP, scores);

end
%%
plot(noise, accuracyAP(:,1),'--k');
hold on;
plot(noise, accuracyAP(:,2),'r'); 
hold on;
plot(noise, accuracyAP(:,3),'-.g'); 
legend('GreedyAP','BFNS', 'SDP','pos',3);
xlabel('noise level');
title('accuracy');  
%%

