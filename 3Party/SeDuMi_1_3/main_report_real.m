function [] = main(fileName)
    %aRangeSum = 0.1:20:200;
    %aRangeTree = 0.001:0.04:0.201;
	aRangeSum = linspace(0.1,200,101);
	aRangeTree = linspace(0.001,0.2,101);
    
    load([fileName '.mat']);
    
    Dist = Dist./max(Dist(:));
    
    for i=[149]
        sc = scores(:,i);
        sc = sc./max(sc);
        root = getRoots(sc, 1);

        aRange = aRangeSum;
        [ResSub, costSub, wSub, dSub] = runSub(aRange, Dist, sc);
        [ResGrSum, costGrSum, wGrSum, dGrSum] = runGreedyAP(aRange, Dist, sc, root);
        [ResSDP, costSDP, wSDP, dSDP] = runSDP(aRange, Dist, sc);

        aRange = aRangeTree;
        [ResGrMin, costGrMin, wGrMin, dGrMin] = runGreedyTree(aRange, Dist, sc, root);
        [wTree, dTree, ResTree, costTree] = runPCST(aRange, Dist, sc, root, X, Y);

         save([fileName '_day' num2str(i) '_out']);
    end
end

