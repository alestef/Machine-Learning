function [ similarity ] = casesSimilarity( a, b, measure )

if (strcmp(measure,'length'))
    % euclidean distance(L2-norm)
    vector1 = zeros(1,45);
    vector2 = zeros(1,45);
   
    for i=1:numel(a.problem)
        vector1(a.problem(i)) = 1;
    end
   
    for i=1:numel(b.problem)
        vector2(b.problem(i)) = 1;
    end
   
    sum = 0;
    
    for i=1:45
        sum = sum + ( vector1(i)-vector2(i) )^2;
    end
   
    similarity = (1 - sqrt(sum) / sqrt(45));
elseif (strcmp(measure, 'matchAU'))
    % matching_AUs / avg_vec_length
    similarity = numel(intersect(a.problem, b.problem)) / ((numel(a.problem) + numel(b.problem)) / 2);
else
    % City-block(Manhattan) distance(L1-norm)
    vector1 = zeros(1,45);
    vector2 = zeros(1,45);

    for i=1:numel(a.problem)
        vector1(a.problem(i)) = 1;
    end
   
    for i=1:numel(b.problem)
        vector2(b.problem(i)) = 1;
    end

    sum = 0;
    
    for i=1:45
        sum = sum + abs(vector1(i)-vector2(i));
    end
   
    similarity = 1 - (sum / (45 + 45));  
end