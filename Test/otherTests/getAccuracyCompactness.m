clear all
noise = 0:0.05:0.51;
k = 10;
for i1 = 1
    for i2 = 1
        for i3 = 1:length(noise)
            fname = [ int2str(i1) '_' int2str(i2) '_' num2str(noise(i3)*100) 'add_out_all.mat'];
            %fname = [ int2str(i1) '_' num2str(noise(i3)*100) 'add_out_all.mat'];
            
            load(fname);
            
            [acGrSum(i3,:), ~, ~] = accuracy(ResGrSum, aRangeSum, scores);
            [acSDP(i3,:), ~, ~] = accuracy(ResSDP, aRangeSum, scores);
            [acSub(i3,:), ~, ~] = accuracy(ResSub, aRangeSum, scores);
            [acMaxCut(i3,:), ~, ~] = accuracy(ResMaxCut, aRangeSum, scores);
            
            [acTree(i3,:), ~, ~] = accuracy(ResTree, aRangeTree, scores);
            [acGrMin(i3,:), ~, ~] = accuracy(ResGrMin, aRangeTree, scores);
            
%             [cmpGrSum(i3,:), ~, ~] = evalCluster(k, Dist, ResGrSum, aRangeSum);
%             [cmpSDP(i3,:), ~, ~] = evalCluster(k, Dist, ResSDP, aRangeSum);
%             [cmpSub(i3,:), ~, ~] = evalCluster(k, Dist, ResSub, aRangeSum);
%             [cmpMaxCut(i3,:), ~, ~] = evalCluster(k, Dist, ResMaxCut, aRangeSum);
%             
%             [cmpTree(i3,:), ~, ~] = evalCluster(k, Dist, ResTree, aRangeTree);
%             [cmpGrMin(i3,:), ~, ~] = evalCluster(k, Dist, ResGrMin, aRangeTree);            
            
        end
        save([ int2str(i1)  '_' int2str(i2) 'add_acc.mat']);
        %save([ int2str(i1) 'add_acc.mat']);
    end
end


