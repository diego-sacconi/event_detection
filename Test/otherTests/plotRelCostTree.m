function [] = plotRelCostTree(file, name)
    load(file);
    
    scores = sc;
    f = figure;
    set(gca,'FontSize',23);
    set(0,'defaultlinelinewidth',2)
    
    
   costTree_ = aRange*sum(scores) - costTree;
        costGrMin_ = aRange*sum(scores) - costGrMin;
        plot(aRange, (-costTree_ + costGrMin_)./costGrMin_);
        xlabel('weight multiplier');
        title('relative cost value: PD vs GreedyT');
    
    saveTightFigure(f,[name 'RelCostTree' '.eps']);  
end

