function predictions = TestTrees(T, x2)
% Where T is a list of all Decision trees, and x2 is a list of examples

predictions = zeros(numel(x2(:,1)), 1);

for i=1:numel(x2(:,1))
    least_depth = intmax('int32');
    best_prediction = 0;
    for j=1:numel(T)
        [prediction, depth] = TestSingleTree(T{j}, x2(i,:));
        if (depth < least_depth) && (prediction == 1)
            least_depth = depth;
            best_prediction = j;
        end
    end
    
    if (best_prediction == 0)
        best_prediction = randi(numel(T));
    end
    
    predictions(i) = best_prediction;
end
