function [] = plotParetoTree(file, name)
%%
    load(file);
    scores = sc;
    
    %scores = distorted;
    scores = sc;
    f = figure;
    set(gca,'FontSize',23);
    set(0,'defaultlinelinewidth',2)
    
    
        plot(dGrMin,(sum(scores)-wGrMin),'--k');
        hold on;
        plot(dTree,(sum(scores)-wTree),'r');
        legend('GreedyT', 'PD','pos',1);
        
    %ylabel('weight component of cost function');
    %xlabel('distance component of cost function');
    %title('Pareto curve');
    xlabel('weight');
    ylabel('distance');
    title('trade-off curve');
    xlim([0 25]); 
    
    saveTightFigure(f,[name 'ParetoTree' '.eps']);  
end

