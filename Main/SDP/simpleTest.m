runs = 500;
load('Barcelona.mat');
scores = scores(:,149);
alpha = 10;
%%
[ResOut(:,1), bestCost(1), t1out, t2out, t3out, t4out] = runNTimesSedumi(runs, alpha,scores, Dist, 1);
%%
[ResOut(:,2), bestCost(2), t1out, t2out, t3out, t4out] = runNTimesSedumi(runs, alpha,scores, Dist, 2);

%[ResOut(:,3), bestCost(3), t1out, t2out, t3out, t4out] = runNTimes(runs, alpha,scores, Dist, 1);
