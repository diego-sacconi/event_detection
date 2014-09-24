function [accGrSum, prGrSum, recallGrSum] = accuracy(Res, aRange, realScores)
    inCluster = (realScores > 0);
    for i = 1:length(aRange)
        res = Res(:,i);
        tp = sum(res(inCluster));
        tn = sum(~res(~inCluster));
        fp = sum(res(~inCluster));
        fn = sum(~res(inCluster));
        prGrSum(i) = tp/(tp + fp);
        recallGrSum(i) = tp/(tp + fn);
        accGrSum(i) = (tp + tn)/(tp + tn + fp + fn);
    end
    %diff = abs(incomp - outcomp);  
end

