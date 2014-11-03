function [ avg_error, avg_confusion_matrix, avg_metrics ] = CrossValidateDecisionTrees(data_set) 
    load(data_set);
    tot_error = 0;
    tot_cmatrix = zeros(6, 6);
    for i = 1:NUM_FOLDS()
        [t_x, t_t, v_x, v_t] = Fold(i, x, y);
        trees = cell(6,1);
        for j=1:6 
            trees{j} = struct('kids',[],'op',[],'class',[]);
            trees{j} = DecisionTree(j, t_x, t_t);
        end
        
        p_t = TestTrees(trees, v_x);
        tot_error = tot_error + CalculateError(v_t, p_t);
        tot_cmatrix = tot_cmatrix + ConfusionMatrix(v_t, p_t);
    end
    
    avg_error = tot_error / NUM_FOLDS();
    avg_confusion_matrix = tot_cmatrix / NUM_FOLDS();
    avg_metrics = ClassificationMetrics(avg_confusion_matrix);
end

