function [] = plotCostSum(file, name)
%%
    load([file '.mat']);
    
    scores = sc;
    
    f = figure;
    %colormap(gray);
    set(gca,'FontSize',23);
    set(0,'defaultlinelinewidth',2);
    
    plot(aRangeSum, costGrSum + sum(Dist(:))/2,'--k');
    hold on;
    %plot(aRangeSum, costSDP + sum(Dist(:))/2,'r');
    %hold on;
    plot(aRangeSum, costSub + sum(Dist(:))/2,'r');
    hold on;           
    plot(aRangeSum, costMaxCut,'-.g');
    hold on;
    plot(aRangeSum, max(sum(scores)*aRangeSum, sum(Dist(:))/2),':b');
    
    legend('GreedyAP', 'BFNS','SDP', 'Trivial','pos', 2);
    %legend('GreedyAP', 'SDP','BFNS', 'Trivial','Location','NorthWest');
    xlabel('weight multiplier');
    ylabel('cost');
    %title('cost function value');  
    
    saveTightFigure(f,[name 'CostAllPairs' '.eps']);    
end

