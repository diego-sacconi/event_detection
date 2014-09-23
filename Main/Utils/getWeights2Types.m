function [scores, scores1, scores2, scores3, avg, theDayData] = getWeights2Types(dataset, chosenDay, varargin)
% Calculates scores for each station. Distinguishes between weekdays and
% weekends.
% For all datasets except Barcelona Bikes weekends are 6 and 7. For
% Barcelona - 7 and 1

% scores - deviation of day-long time-series
% scores1 - deviation of time-series from 0am to 9am
% scores2 - deviation of time-series from 9am to 5pm
% scores3 - deviation of time-series from 5pm to 0am

    switch nargin
    case 2
        weekends = [6, 7];
        workdays = 1:5;
    case 3
        weekends = [1, 7];
        workdays = 2:6;
    end
       
    theDayData = dataset(dataset(:,1) == chosenDay,:);
    theWeekday = theDayData(1,2);
    theWeekdayData = [];
    if ismember(theWeekday, weekends)
        for i = weekends
            theWeekdayData = [theWeekdayData; dataset(dataset(:,2) == i,:)];
        end  
    else        
        for i = workdays
            theWeekdayData = [theWeekdayData; dataset(dataset(:,2) == i,:)];
        end        
    end
    stations = theDayData(:,3);
    
    avg = [];
    for s = stations'
        avg = [avg; mean(theWeekdayData(theWeekdayData(:,3) == s,:),1)];
    end
    
   
    
    [avg] = getMeanWOoutliers(theWeekdayData, avg, 0.75);
    %[avg] = getMeanWOoutliers(theWeekdayData, avg, 0.95);
    scores = sqrt(sum(((avg(:,4:end) - theDayData(:,4:end)).^2),2));
    
    scores1 = sqrt(sum(((avg(:,4:28) - theDayData(:,4:28)).^2),2));
    scores2 = sqrt(sum(((avg(:,29:53) - theDayData(:,29:53)).^2),2));
    scores3 = sqrt(sum(((avg(:,35:75) - theDayData(:,35:75)).^2),2));
end

