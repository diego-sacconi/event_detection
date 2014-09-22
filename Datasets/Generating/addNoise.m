function [distorted] = addNoise(scores, nlevel)
    noise = rand(size(scores));
    noiseM = rand(size(scores));
    %frac = 0.9;
    frac = nlevel; % good
    noiseM = (noiseM < frac);
    distorted = scores;
    distorted(noiseM) = noise(noiseM);
    %distorted = distorted/max(distorted);
end

