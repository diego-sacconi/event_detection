function [vert, K_out] = Kulldorf(scores_real, avg, Dist, X, Y)
    %%
    chosenDay = 149;
    [~, avg, theDayData] = getWeights2Types(dataset, chosenDay);
    scores_real = theDayData(:,4:end);
    scores_real = scores_real(:,end);
    avg = avg(:,4:end);
    avg = avg(:,end);
    %[scores1, scores2, scores3, avg, theDayData] = getWeightsParts(dataset, chosenDay);
    nElements = 30;
    intX = linspace(min(X), max(X), nElements);
    intY = linspace(min(Y), max(Y), nElements);    
    
    [gridX, gridY] = meshgrid(intX, intY);

    tree = kdtree_build( [gridX(:) gridY(:)] );
    gridIDX = kdtree_nearest_neighbor(tree, [X Y]);
    kdtree_delete(tree);
    gridScores = zeros(size(scores_real,2), nElements*nElements);
    gridAvg = zeros(size(scores_real,2), nElements*nElements);
    for i = 1:size(scores_real,2)
        t = accumarray(gridIDX, scores_real(:,i));
        gridScores(i,1:size(t,1)) = t';
        t =  accumarray(gridIDX, avg(:,i));
        gridAvg(i,1:size(t)) = t';
    end
    
    %gridScores = accumarray(gridIDX, scores_real);
    %gridAvg  = accumarray(gridIDX, avg);
    scores3D = zeros(size(scores_real,2),nElements, nElements);
    avg3D = zeros(size(scores_real,2),nElements, nElements);
    for i = 1:size(scores_real,2)
        scores3D(i,:,:) = reshape(gridScores(i,:), nElements, nElements);
        avg3D(i,:,:) = reshape(gridAvg(i,:), nElements, nElements);        
    end
    
    %gridScores = reshape(gridScores, nElements, nElements);
    %gridAvg = reshape(gridAvg, nElements, nElements);
    %%
    intX = linspace(min(X), max(X), nElements);
    intY = linspace(min(Y), max(Y), nElements);    
    
    [gridX, gridY] = meshgrid(intX, intY);
    avg3D = ones(1, nElements, nElements);
    scores3D = ones(1, nElements, nElements);
    scores3D(1,5:10,5:10) = 10;
    t = scores3D(1,:,:);
    scatter(gridX(:),gridY(:),t(:),'filled','MarkerEdgeColor',[0.5 0.5 0.5])
    scatter(gridX(:),gridY(:),t(:)+10,gridout(:),'filled','MarkerEdgeColor',[0.5 0.5 0.5])
    
    %%
    M = sum(sum(scores3D,2),3);
    B = sum(sum(avg3D,2),3);    
    
    K_out = -1000;
    gridout = zeros(nElements,nElements);
    for i1 = 1:nElements
        for i2 = (i1+1):nElements
            for j1 = 1:nElements
                for j2 = (j1+1):nElements
                    m = sum(sum(scores3D(:,i1:i2,j1:j2),2),3)./M;
                    b = sum(sum(avg3D(:,i1:i2,j1:j2),2),3)./B;
                    %if max(b)>0
                    %    max(b)
                    %end
                    
                    K = sum(m.*log(m./b)+(1-m).*log((1-m)./(1-b)));               
                    if K > K_out                        
                        K_out = K;
                        gridout = zeros(nElements,nElements);
                        gridout(i1:i2,j1:j2)=1;
                    end
                end
            end
        end
    end 
    %%
    %gridout = gridout';
    t = gridout(:);
    res = t(gridIDX);
    %scatter(X,Y,sum(scores_real,2),res)
    figure;
    %scatter(gridX(:), gridY(:));
    %hold on
    %scatter(X,Y,scores,res)
    scatter(X,Y,70*(scores_real+0.1),res,'filled','MarkerEdgeColor',[0.5 0.5 0.5])

    %%
end
