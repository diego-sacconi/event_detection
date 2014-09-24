function [ output_args ] = plotMap(file, name, googleMap)
    
    load([file '.mat'])
    %%
    %name = 'curveTree';
    name = 'oneAP';
    %googleMap = 1;
    f = figure; colormap(gray);
    %scatter(X_d,Y_d,100*(distorted+0.1),ResGrSum(:,2),'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    t = ResGrSum(:,2);
    scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(t)-t); 1.3],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    axis off;    
    if googleMap == 1
        plot_google_map();
    end
    %saveTightFigure(f, [name 'Map' '.eps'])
    %%
    %name = 'curveTree'; %ResTree(:,31)
    %name = 'curveAP'; %ResGrSum(:,5)
    %name = 'twoAP'; %ResMaxCut(:,7)
    %name = 'twoTree'; %ResTree(:,32)
    %name = 'oneTree'; %ResTree(:,27)
    %name = 'crossBAP'; %ResMaxCut(:,35);
    %name = 'crossBTree'; %ResTree(:,33);
    %name = 'twoNYAP'; %ResGrSum(:,4);
    name = 'twoNYTree'; %ResGrMin(:,39);
    googleMap = 1;
    f = figure; colormap(gray);
    %scatter(X_d,Y_d,100*(distorted+0.1),ResGrSum(:,2),'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %t = ResGrSum(:,4);
    t = ResGrMin(:,39);
    %t = ResTree(:,39);
    
    back = scores==0;
    backX = X_d(back);
    backY = Y_d(back);
    backSc = distorted(back);
    
    front = logical(t);
    frontX = X_d(front);
    frontY = Y_d(front);
    frontSc = distorted(front);
    
    %scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(t)-t); 1.3],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %hold on;
    scatter(X_d, Y_d,100*(distorted+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    hold on;
    scatter(frontX, frontY,100*(frontSc+0.3),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
    axis off;    
     if googleMap == 1
         plot_google_map();
     end
     saveTightFigure(f, [name 'Map' '.eps'])
    %%
    %% MinnID - ResTree(:,3)
    %% BarCatND - ResGrSum(:,7)
    %% WDCMayDay - ResTree(:,3)
    %% LAMayDay - ResSDP(:,2);
    
    f = figure; colormap(gray);
    j = 3;
    d = 194;
    %t = ResGrSum(:,1);
    %t = ResGrMin(:,11);
    %t = ResSDP(:,5);
    %t = out(:,j)
    %t = ResTree(:,3);
    
    back = t==0;
    backX = X(back);
    backY = Y(back);
    s = scores(:,d);
    s = s./max(s);
    backSc = s(back);
    
    front = logical(t);
    frontX = X(front);
    frontY = Y(front);
    frontSc = s(front);
    
    %scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(t)-t); 1.3],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %hold on;
    scatter(X, Y,100*(s),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    hold on;
    scatter(frontX, frontY,100*(frontSc),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
    axis off;    
    %f googleMap == 1
         plot_google_map();
    %end
    saveTightFigure(f, 'NYSep')
    %%
    %% MinnID - ResTree(:,3)
    %% BarCatND - ResGrSum(:,7)
    %% WDCMayDay - ResTree(:,3)
    %% LAMayDay - ResSDP(:,2);
    %% NYSep - t = ResSDP(:,5);
    
    f = figure; colormap(gray);
    %j = 3;
    %d = 194;
    %t = ResSDP(:,5);
    %t = ResGrMin(:,11);
    %t = ResSDP(:,5);
    %t = out(:,j)
    %t = ResTree(:,3);
    %t = ResGrSum;
    t = ResMaxCut;
    %t = ResSDP;
    %t = ResTree;
    back = t==0;
    backX = X(back);
    backY = Y(back);
    %s = scores(:,d);
    %s = s./max(s);
    backSc = sc(back);
    
    front = logical(t);
    frontX = X(front);
    frontY = Y(front);
    frontSc = sc(front);
    
    %scatter([X_d; min(X_d)],[Y_d; min(Y_d)],[100*(distorted+0.3); 0.0001],[(max(t)-t); 1.3],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    %scatter(backX, backY,100*(backSc+0.3),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.5 0.5 0.5]);
    %hold on;
    scatter(X, Y,100*(sc),[0.75 0.75 0.75],'filled','MarkerEdgeColor',[0.75 0.75 0.75]);
    hold on;
    scatter(frontX, frontY,100*(frontSc),[0.25 0.25 0.25],'filled','MarkerEdgeColor','k');
    axis off;    
    %f googleMap == 1
         plot_google_map();
    %end
    saveTightFigure(f, 'NYSep2')
end

