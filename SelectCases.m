function [ highestK ] = SelectCases( novel_case, near_cases, cbr, k)
    % This function uses Quick Select to select the top K cases from a list
    % of cases (near_cases) in terms of their similarity to novel_case.
    % Get the halfway point.
    middle = idivide(int32(numel(near_cases)), int32(2), 'ceil');
    pivot = near_cases(middle);
    % Split the near_cases list into left and right
    left = struct('problem', {}, 'typicality', {}, 'solution', {});
    right = pivot;

    for i=1:numel(near_cases) 
        if (casesSimilarity(novel_case, near_cases(i), cbr.measure) <= ...
                casesSimilarity(novel_case, pivot, cbr.measure))
            left(end + 1) = near_cases(i);
        else
            right(end + 1) = near_cases(i);
        end
    end
        
    % Depending on the length of the right list, recurse or do not recurse
    if numel(right) == k 
        % If we've got the right amount, return.
        highestK = right;
    elseif numel(right) > k
        % If we've got too many, split again.        
        highestK = SelectCases(novel_case, right, cbr, k);
    else
        % if we've got too few, split left and fix the total.
        required = k - numel(right);
        remaining_cases = SelectCases(novel_case, left, cbr, required);
        highestK = [remaining_cases, right];
    end
end

