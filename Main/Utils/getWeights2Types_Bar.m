function [scores, avg, theDayData] = getWeights2Types(dataset, chosenDay)
        
    theDayData = dataset(dataset(:,1) == chosenDay,:);
    theWeekday = theDayData(1,2);
    theWeekdayData = [];
    if (theWeekday == 7 || theWeekday == 1)
    %if (theWeekday == 6 || theWeekday == 7)
        for i=[1,7]
        %for i = [6,7]
            theWeekdayData = [theWeekdayData; dataset(dataset(:,2) == i,:)];
        end  
    else
        for i = 2:6
        %for i = 1:5
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
    
end

