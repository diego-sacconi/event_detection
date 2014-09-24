function [] = plotAccLTree(file, pname)
%%
    load([file '.mat']);
    
    n = 5;   
    f = figure;
    set(gca,'FontSize',27);
    set(0,'defaultlinelinewidth',2);
    
    plot(aRangeTree, acGrMin(n,:),'--r');
        hold on;
        plot(aRangeTree, acTree(n,:));
        legend('GreedyT', 'PD','pos',4);
        xlabel('weight multiplier');
        %title('accuracy');   
    
        xlim([0 0.2]); 
        set(gca,'XTick',[0 0.05 0.1 0.15 0.2])
        %ymin = min([min(acGrSum(:,a)) min(acSub(:,a)) min(acMaxCut(:,a))]);
        %ymin = ymin-1;
        %ymax = max([max(acGrSum(:,a)) max(acSub(:,a)) max(acMaxCut(:,a))]);
        ylim([0.8 0.9]);
        %ylim([ymin ymax]);
        set(gca,'YTick',[0.6 0.7 0.8 0.9 1])
        %ytNew = yt;
        yt = get(gca, 'YTick'); 
        ytNew = {};
        for i = 1:size(yt, 2)       
            strrep(num2str(yt(i)),'0.','.')
            ytNew(i) = mat2cell(strrep(num2str(yt(i)),'0.','.'));
        end
%         xt = get(gca, 'XTick');
%         xtNew = {};
%         for i = 1:size(xt, 2)       
%             strrep(num2str(xt(i)),'0.','.')
%             xtNew(i) = mat2cell(strrep(num2str(xt(i)),'0.','.'));
%         end
        set(gca, 'YTickLabel', ytNew);
        %set(gca, 'XTickLabel', xtNew);
    saveTightFigure(f,[pname 'AccLTree' '.eps']);    
end

