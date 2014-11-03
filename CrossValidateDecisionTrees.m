function [ average_error ] = CrossValidateDecisionTrees(data_set) 
    load(data_set);
    total_error = 0;
    for i = 1:NUM_FOLDS()
        [t_x, t_t, v_x, v_t] = Fold(i, x, y);
        trees = cell(6,1);
        for j=1:6 
            trees{j} = struct('kids',[],'op',[],'class',[]);
            trees{j} = DecisionTree(j, t_x, t_t);
        end
        
        p_t = TestTrees(trees, v_x);
        total_error = total_error + CalculateError(v_t, p_t);
    end
    
    average_error = total_error / NUM_FOLDS();
end

