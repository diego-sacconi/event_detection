function [ output_args ] = submodLoop(scores, Dist, alpha)
    [vert, f] = subMod_third(scores, Dist, alpha);
    while vert == vertNext
        [vertNext, f] = subMod_third(scores, Dist, alpha);
    end
end

