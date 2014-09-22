function[Coord, dataset, Dist] = loadInput(fileCoord, fileData)
    %Coord = dlmread('Latitude_Longitude_stations.txt');
    %Coord = dlmread('trueCoord.txt');
    Coord = dlmread(fileCoord);
    %Coord([77, 245, 383, 399, 403, 417, 422], :) = [];
    %dataset = dlmread('allWithAvgAddInf_matlab.csv');
    dataset = dlmread(fileData);
    %dataset(find(dataset(:,3) == 394),:) = [];
    %Dist = squareform(pdist(Coord(:,2:3)));
    Dist = squareform(pdist(Coord(:,1:2)));
end

