function cmatrix = ConfusionMatrix(data_set_filename)
    load(data_set_filename);

    T = cell(6,1);

    cutoff = round(numel(y)/10)*9;

    training_examples = x(1:cutoff,:);
    training_targets = y(1:cutoff);
    
    real_targets = y(cutoff+1:numel(y));

    for i=1:6 
        T{i} = struct('kids',[],'op',[],'class',[]);
        T{i} = DecisionTree(i, training_examples, training_targets);
    end

    predictions = TestTrees(T,x(cutoff+1:numel(y),:));

    cmatrix = zeros(6,6);

    for i=1:numel(real_targets)
        cmatrix(real_targets(i), predictions(i)) = cmatrix(real_targets(i), predictions(i)) + 1;
    end
end

