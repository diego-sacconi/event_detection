function [xsolOut, fsolOut] = exactGrb(Dist, scores, alpha, runs)
    clear model;    
    n = size(Dist,1);
    model.modelsense = 'max';
    model.Q = sparse(-0.5*Dist);
    model.A = sparse(1,1,1,1,n);
    model.obj = alpha*scores;
    model.rhs = 0;
    model.sense = '>';
    model.vtype = 'B';
    params.TimeLimit = 3600;
    
    fsolOut = -intmax;
    xsolOut = [];
    
    for i = 1:runs
    
        model.start = double(rand(n,1)>0.5);
        results  = gurobi(model,params);
        fsol = results.objval;
        xsol = results.x;
        if (fsol > fsolOut)
            fsolOut = fsol;
            xsolOut = xsol;
        end
    end
    xsolOut = xsolOut > 0.5;
end

