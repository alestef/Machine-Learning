function [ case_struct ] = retreive( cbr, newcase )

    best = 0;
    for i=1:numel(cbr.buckets)
        if (casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure ) >  best)
            cbr.buckets(i).origin = best;
        end
    end
    
    maxDistanceToCheck = cbr.radius + best;
    listNearCases = newcase;
    sizeListKcases = 0;
    
    for i=1:numel(cbr.buckets)
        if (casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure ) <=  maxDistanceToCheck)
            for j=1:numel(cbr.buckets(i).elements)
                tmpCase.typicality = cbr.buckets(i).elements(j).typicality;
                tmpCase.solution = cbr.buckets(i).elements(j).solution;
                sizeListKcases = sizeListKcases + 1;
                listNearCases(sizeListKcases) = tmpCase;
            end
        end
    end
    
    topKCases = selectCases( newcase, listNearCases, cbr, k);
    labelsProbability = zeros(6);
    sumDistanceTypicality = 0;
    
    for i=1:cbr.k
        distanceTimesTypicality = labelsProbability(topKCases(i).solution) + ...
            topKCases(i).typicality*casesSimilarity(topKCases(i), newcase, cbr.measure );
        
        labelsProbability(topKCases(i).solution) = distanceTimesTypicality;
        
        sumDistanceTypicality = sumDistanceTypicality + distanceTimesTypicality;
    end
    
    for i=1:6
        labelsProbability(i) = labelsProbability(i)/sumDistanceTypicality;
    end
   
    [~, idx] = max(labelsProbability);
    
    case_struct.solution = idx;

end

