function [ case_struct ] = retreive( cbr, newcase )

    best = 0;
    for i=1:numel(cbr.buckets)
        if (casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure ) >  best)
            cbr.buckets(i).origin = best;
        end
    end
    
    maxdistanceToCheck = cbr.radius + best;
    bestCase.typicality = -1;
    bestCase.solution = '';
    bestSimilarity = 0;
    
    for i=1:numel(cbr.buckets)
        if (casesSimilarity(cbr.buckets(i).origin, newcase, cbr.measure ) <=  maxDistanceToCheck)
            for j=1:numel(cbr.buckets(i).elements)
                if (( casesSimilarity(cbr.buckets(i).elements(j), newcase, cbr.measure) < bestSimilarityVal || ...
                    (casesSimilarity(cbr.buckets(i).elements(j), newcase, cbr.measure) == bestSimilarity  && ...
                    cbr.buckets(i).elements(j).typicality > bestCase.typicality) ...
                    ))

                    bestSimilarity = casesSimilarity(cbr.buckets(i).elements(j), newcase, cbr.measure);
                    bestCase.solution = cbr.buckets(i).elements(j).solution;
                    bestCase.typicality = cbr.buckets(i).elements(j).typicality;   
                    bestCase.problem =  cbr.buckets(i).elements(j).problem;
                end
            end
        end
    end
    
    case_struct = bestCase;

end

