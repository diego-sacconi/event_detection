function [avgOut] = getMeanWOoutliers(theWeekdayData, avg, p)
    stations = unique(theWeekdayData(:,3));

    t = size(theWeekdayData,1)/length(stations);

    scores = [theWeekdayData(:,1:3) sqrt(sum(((repmat(avg(:,4:end),t,1) - theWeekdayData(:,4:end)).^2),2))];

    avgOut = [];
    for s = stations'
        t = scores(scores(:,3) == s,:);
        tData = theWeekdayData(theWeekdayData(:,3) == s,:);
        q = quantile(t(:,4),p);
        avgOut = [avgOut; mean(tData(t(:,4) <= q,:),1)];
    end
end

