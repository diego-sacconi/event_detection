function [out] = getRoots(scores, n)
    [~, idx] = sort(scores,'descend'); 
    out = idx(1:n);
end

