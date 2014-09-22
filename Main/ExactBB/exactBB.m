function [xsolOut, fsolOut] = exactBB(Dist, scores, alpha, runs)
    xsolOut = 0;
    fsolOut = -intmax;
    n = length(scores);
    ivar = 1:n;
    options = [];    
    %options.integtol = 1e-6;
    %options.solver   = 'quadprog';
    
    ev = eig(Dist);
    Dist = Dist - ev(1).*eye(n);
    
    for i = 1:runs
    
        x0	= rand(length(scores),1);
        [xsol, fsol, flag, ef] = miqp(Dist, -alpha.*scores, [], [], [], [], ivar, [], [], x0, options);
        
        if (-fsol > fsolOut)
            fsolOut = -fsol;
            xsolOut = xsol;
        end
    end
    xsolOut = xsolOut > 0.5;
end

