function [] = plotParetoSum(file, name)
%%
    load([file '.mat']);
    
    f = figure;
    set(gca,'FontSize',23);
    set(0,'defaultlinelinewidth',2);
    
    for ii = 1:size(ResMaxCut,2)
        res = logical(ResMaxCut(:,ii)); 
        wMaxCut(ii) = sum(sc(res));
        dMaxCut(ii) = sum(sum(Dist(res,res)))/2;    
    end
    
    plot(wGrSum, sum(Dist(:))/2-dGrSum,'--k');
    hold on;
    %plot(wSDP, sum(Dist(:))/2-dSDP,'r');
    %hold on;
    plot(wSub, sum(Dist(:))/2-dSub,'r');
    hold on;
    plot(wMaxCut, sum(Dist(:))/2-dMaxCut,'-.g');
    
    
    legend('GreedyAP', 'BFNS', 'SDP', 'pos',3);
    %xlabel('weight component of cost function');
    %ylabel('distance component of cost function');
    xlabel('weight');
    ylabel('distance');
    title('trade-off curve');
    xlim([0 ]); 
    
    saveTightFigure(f,[name 'ParetoAllPairs' '.eps']);    
end

