function [] = plotMap(file, name, googleMap)
    %%

    googleMap = 1;
    name = 'crossBNoise'; 
    %name = 'twoNYNoise'; 
    
    %googleMap = 0;
    %name = 'curveNoise'; 
    
    %load([file '.mat'])
    f = figure; colormap(gray);
    %scatter(X_d,Y_d,100*(distorted+0.3),distorted,'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %hold on;
    %colormap(jet);
    %scatter(X_d,Y_d,100*(distorted+0.3),~(scores>0)*0.25,'filled','MarkerEdgeColor','k')
    scatter(X_d,Y_d,100*(distorted+0.3),~(scores>0),'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(scores)-scores); 1.5],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter(X_d,Y_d,100*(distorted+0.3),scores,'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    hold on
    planted = (scores>0);
    scatter(X_d(planted),Y_d(planted),100*(distorted(planted)+0.3),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
    axis off;    
    if googleMap == 1
        plot_google_map();
    end
    saveTightFigure(f, [name 'Map' '.eps'])
    %%
    f = figure; colormap(gray);
    %scatter(X_d,Y_d,100*(distorted+0.3),distorted,'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %hold on;
    %colormap(jet);
    %scatter(X_d,Y_d,100*(distorted+0.3),~(scores>0)*0.25,'filled','MarkerEdgeColor','k')
    scatter(X,Y,100*(distorted+0.3),~(scores>0),'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(scores)-scores); 1.5],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter(X_d,Y_d,100*(distorted+0.3),scores,'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    hold on
    planted = (scores>0);
    scatter(X_d(planted),Y_d(planted),100*(distorted(planted)+0.3),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
    axis off;    
    if googleMap == 1
        plot_google_map();
    end
    %%
end

