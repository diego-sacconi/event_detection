file = 'Barcelona_day149_out_all';
name = 'Barcelona149';
%%
file = 'NY_day130_out_all';
name = 'NY130';

%%
plotCostTree(file, name)
plotRelCostTree(file, name)
plotParetoTree(file, name)
%%
%plotCostSum(file, name);

plotRelCostSum(file, name)

plotParetoSum(file, name)
%%
file = '9add_acc';
%file = '9_5add_acc';
pname = 'one';
%%
file = '1add_acc';
pname = 'two';
%%
file = '2add_acc';
pname = 'curve';
%%
file = '1_1add_acc';
pname = 'twoNY';
%%
file = '2_2add_acc';
pname = 'crossB';
%%
plotAccNoiseSum(file, pname);
plotAccLSum(file, pname);
plotCompLSum(file, pname);
%%
plotAccNoiseTree(file, pname);
plotAccLTree(file, pname);
plotCompLTree(file, pname);


