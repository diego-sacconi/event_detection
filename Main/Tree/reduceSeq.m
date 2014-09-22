function[Edges, Vertices, onEdg, idx] = reduceSeq(Edges, Vertices, root, X,Y)

     %x_ = repmat(1:10,10,1); y_ = repmat(1:10,10,1)'; 
     
    [val, onEdg, idx] = getValue(Edges, Vertices);
    Vertices.potential = Vertices.potential - val*Vertices.active;
    Edges.deficit(Edges.active > 0) = Edges.deficit(Edges.active > 0) - val*Edges.active(Edges.active > 0);
    %Edges.deficit(logical(eye(size(Edges.active,1)))) = dt;   
    
    if (onEdg == 0)         
        Vertices.order(idx) = max(Vertices.order) + 1;
        vertCmp = find(Vertices.compName == Vertices.compName(idx));
        Vertices.active(vertCmp) = 0;
        Vertices.potential(vertCmp) = 0;
        
        rest = setdiff((1:length(Vertices.active)), vertCmp);
        
        t = (~(Edges.active(vertCmp, rest) == 1)).*Edges.active(vertCmp, rest) - (Edges.active(vertCmp, rest) == 1);
        Edges.active(vertCmp, rest) = t;
        Edges.active(rest, vertCmp) = t';
        
        t = (~(Edges.active(vertCmp, rest) == 2)).*Edges.active(vertCmp, rest) + (Edges.active(vertCmp, rest) == 2);
        Edges.active(vertCmp, rest) = t;
        Edges.active(rest, vertCmp) = t';
        
    else
        [i,j] = ind2sub(size(Edges.deficit),idx);
        m = max(Edges.order(:));
        Edges.order(i,j) = m + 1;
        Edges.order(j,i) = m + 1;
        
        cmp1 = Vertices.compName(i); cmp2 = Vertices.compName(j);
        vertCmp1 = find(Vertices.compName == cmp1);
        vertCmp2 = find(Vertices.compName == cmp2);
        vertCmp = [vertCmp1; vertCmp2];
        
        Vertices.compName(vertCmp) = cmp1;       
        Vertices.potential(vertCmp) = Vertices.potential(i) + Vertices.potential(j);       
          
        rest = setdiff((1:length(Vertices.active)), vertCmp);
        
        goAct = vertCmp((Vertices.active(vertCmp) == 0));
        
        
        t = (~(Edges.active(goAct, rest) == 1)).*Edges.active(goAct, rest) + 2*(Edges.active(goAct, rest) == 1);
        Edges.active(goAct, rest) = t;
        Edges.active(rest, goAct) = t';
        
        t = (~(Edges.active(goAct, rest) == -1)).*Edges.active(goAct, rest) + (Edges.active(goAct, rest) == -1);
        Edges.active(goAct, rest) = t;
        Edges.active(rest, goAct) = t';
        
        Vertices.active(vertCmp) = 1;
        
        if ismember(root, vertCmp)            
            Vertices.active(vertCmp) = 0;
            t = (~(Edges.active(vertCmp, rest) == 1)).*Edges.active(vertCmp, rest) - (Edges.active(vertCmp, rest) == 1);
                        
            Edges.active(vertCmp, rest) = t;
            Edges.active(rest,vertCmp) = t';
            
            t = (~(Edges.active(vertCmp, rest) == 2)).*Edges.active(vertCmp, rest) + (Edges.active(vertCmp, rest) == 2);
                        
            Edges.active(vertCmp, rest) = t;
            Edges.active(rest,vertCmp) = t';
        end        
            
        Edges.active(vertCmp1, vertCmp2) = -logical(Edges.active(vertCmp1, vertCmp2));
        Edges.active(vertCmp2, vertCmp1) = -logical(Edges.active(vertCmp2, vertCmp1));
        
    end
    %set(gcf, 'Position', get(0,'Screensize'));
    %set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    %set(gcf,'Visible','off');
    %wgPlot(Edges.order + 0.1, [X Y], 'vertexWeight', Vertices.active + 0.1,'edgeWidth',5,'vertexMetadata',Vertices.potential + 0.1);
    %name = ['D:\matlab_scripts\traffic\TreesCorrect\Pictures\' num2str(floor(now*10000000))];
    %eval(['print -dpng ', name])
    %idx    
end