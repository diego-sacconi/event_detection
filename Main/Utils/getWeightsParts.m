function [scores1, scores2, scores3, avg, theDayData] = getWeightsParts(dataset, chosenDay)        
    theDayData = dataset(dataset(:,1) == chosenDay,:);
    theWeekday = theDayData(1,2);
    theWeekdayData = [];
    if (theWeekday == 7 || theWeekday == 1)
        for i=[1,7]
            theWeekdayData = [theWeekdayData; dataset(dataset(:,2) == i,:)];
        end  
    else
        for i = 2:6
            theWeekdayData = [theWeekdayData; dataset(dataset(:,2) == i,:)];
        end        
    end
    stations = theDayData(:,3);
    
    avg = [];
    for s = stations'
        avg = [avg; mean(theWeekdayData(theWeekdayData(:,3) == s,:),1)];
    end
    
    
    [avg] = getMeanWOoutliers(theWeekdayData, avg, 0.75);
    %scores = sqrt(sum(((avg(:,4:end) - theDayData(:,4:end)).^2),2));
    
    scores1 = sqrt(sum(((avg(:,4:28) - theDayData(:,4:28)).^2),2));
    scores2 = sqrt(sum(((avg(:,29:53) - theDayData(:,29:53)).^2),2));
    scores3 = sqrt(sum(((avg(:,35:75) - theDayData(:,35:75)).^2),2));
        
    %Dist = squareform(pdist(Coord(:,2:3))); 
end

