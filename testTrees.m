function predictions = testTrees(T, x2)

predictions = zeros(numel(x2), 1);

for i=1:numel(x2)
    least_depth = intmax('int32');
    best_prediction = [];
    for j=1:numel(T)
        [prediction, depth] = TestSingleTree(T(j), example);
        if (depth < least_depth) && (prediction)
            least_depth = depth;
            best_prediction = j;
        end
    end
    
    predictions(i) = best_prediction;
end
