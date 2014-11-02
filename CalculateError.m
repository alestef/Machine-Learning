function [ result ] = CalculateError(targets, predicted_targets)
    total = 0;
    for i=1:numel(targets),
        if (targets(i) ~= predicted_targets(i))
            total = total + 1;
        end
    end
    
    result = total / numel(targets);
end

