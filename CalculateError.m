function [ result ] = CalculateError(examples, targets, predicted_targets)
    total = 0;
    for i=1:numel(examples),
        if (targets(i) ~= predicted_targets(i))
            total = total + 1;
        end
    end
    
    result = total / numel(examples);
end

