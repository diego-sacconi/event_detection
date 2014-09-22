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
		runs = 500;
		for ii = 1:length(aRange)
			[ResMaxCut(:,ii), costMaxCut(ii), ~, ~, ~, ~] = runNTimesSedumi(runs,aRange(ii),sc, Dist, 2);
		end
		
         save([fileName 'MaxCut_day' num2str(i) '_out']);
    end
end

