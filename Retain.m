function [ cbr ] = Retain(cbr, cbr_case)
    fits_any_bucket = 0;
    % Find buckets that cbr_case fits into
    for i=1:numel(cbr.buckets)
        if (casesSimilarity(cbr.buckets(i).origin, cbr_case, cbr.measure ) >  (1 - cbr.radius))
            fits_any_bucket = 1;
            % foreach matching bucket
            % If the case exists in the bucket, increment typicality
            aleady_exists = 0;
            for j=1:numel(cbr.buckets(i).elements)
                if (isequal(cbr.buckets(i).elements(j).problem, cbr_case.problem) && cbr.buckets(i).elements(j).solution == cbr_case.solution)
                    cbr.buckets(i).elements(j).typicality = cbr.buckets(i).elements(j).typicality + 1;
                    aleady_exists = 1;
                end
            end
            
             % otherwise, add the case               
            if (~aleady_exists)
                cbr.buckets(i).elements(end+1) = cbr_case;
            end
        end
    end
    
    % if no buckets are within radius
    if (~fits_any_bucket)
        % create a new bucket with cbr_case as the origin
        cbr.buckets(end+1) = struct('origin', cbr_case, 'elements', cbr_case);
    end
end

