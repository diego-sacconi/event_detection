function [] = plotCostTree(file, name)
%%
    load(file);
    
    f = figure;
    scores = sc;
    set(gca,'FontSize',23);
    set(0,'defaultlinelinewidth',2)
    aRange = aRangeTree;
    
    
        plot(aRange, aRange*sum(scores)-costGrMin,'--k');
        hold on;
        plot(aRange, aRange*sum(scores)-costTree,'r');
        legend('GreedyT', 'PD','pos',4);
        xlabel('weight multiplier');
        %title('cost function value');
        ylabel('cost');
    
    saveTightFigure(f,[name 'CostTree' '.eps']);  
end

