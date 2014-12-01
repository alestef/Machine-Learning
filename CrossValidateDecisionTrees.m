function [ avg_error, avg_confusion_matrix, avg_metrics, other_metrics ] = CrossValidateDecisionTrees(data_set) 
    load(data_set);
    tot_error = 0;
    tot_cmatrix = zeros(6, 6);
    curr_cmatrix = zeros(6, 6);
    other_metrics = zeros(10, 6);
    for i = 1:NUM_FOLDS()
        [t_x, t_t, v_x, v_t] = Fold(i, x, y);
        trees = cell(6,1);
        for j=1:6 
            trees{j} = struct('kids',[],'op',[],'class',[]);
            trees{j} = DecisionTree(j, t_x, t_t);
        end
        
        p_t = TestTrees(trees, v_x);
        
        %Other metrics stuff
        %Used in t-tests
        curr_cmatrix = ConfusionMatrix(v_t, p_t);
        for j = 1:6
            tp_tn = sum(diag(curr_cmatrix));
            tp_tn_fp_fn = tp_tn + sum(curr_cmatrix(:,j)) + sum(curr_cmatrix(j,:));
            other_metrics(i,j) = tp_tn/tp_tn_fp_fn;
        end
        %End of other metrics stuff
        
        tot_error = tot_error + CalculateError(v_t, p_t);
        tot_cmatrix = tot_cmatrix + curr_cmatrix;
    end
    
    avg_error = tot_error / NUM_FOLDS();
    avg_confusion_matrix = tot_cmatrix / NUM_FOLDS();
    avg_metrics = ClassificationMetrics(avg_confusion_matrix);
end

