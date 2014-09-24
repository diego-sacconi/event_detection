function [] = plotRelCostSum(file, name)
    load([file '.mat']);
    %%
    aRange = aRangeSum;
    f = figure;
    scores = sc;
    set(gca,'FontSize',16);
    set(0,'defaultlinelinewidth',2);
    
      t = sum(Dist(:))/2;
        
        costGrSum_ = costGrSum + t;
        plot(aRange, (-costMaxCut + costGrSum_)./max(costGrSum_, costMaxCut));
        xlabel('weight multiplier');
        title('relative cost value: MaxCut vs GreedyAP');  
    
    saveTightFigure(f,[name 'RelCostAllPairs' '.eps']); 
    %%
end

