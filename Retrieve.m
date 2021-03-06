function [ case_struct, topKCases ] = Retrieve( cbr, newcase )
    
    %disp('calculating best');
    %best = 0;
    %for i=1:numel(cbr.buckets)
    %    cur = casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure);
    %    if cur > best
    %        best = cur;
    %    end
    %end
    %best = 1 - best;
    %maxDistanceToCheck = cbr.radius + best;
    %listNearCases = struct('id', {}, 'problem', {}, 'typicality', {}, 'solution', {})
    %disp('concat buckets');
    %for i=1:numel(cbr.buckets)
    %    if ((1 - casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure)) <=  maxDistanceToCheck)
    %        listNearCases = [listNearCases, cbr.buckets(i).elements];
    %    end
    %end

    listNearCases = cbr.flat_initial_storage;
    topKCases = SelectCases( newcase, listNearCases, cbr, cbr.k);
    labelsProbability = zeros(6, 1);
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
    
    case_struct = assignCase(newcase.problem, idx);
end

