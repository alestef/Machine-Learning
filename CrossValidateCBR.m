function [ avg_error, avg_confusion_matrix, avg_metrics ] = CrossValidateCBR(data_set) 
    load(data_set);
    tot_error = 0;
    tot_cmatrix = zeros(6, 6);
    warning('off','all')
    for i = 1:NUM_FOLDS()
        disp(['Cross-Validation Fold Number: ', num2str(i)]);
        [t_x, t_t, v_x, v_t] = Fold(i, x, y);
        
        disp(['Creating CBR Number ', num2str(i)]);
        cbr = CBRinit(t_x, t_t);
        disp(['Testing CBR Number ', num2str(i)]);        
        p_t = TestCBR(cbr, v_x);
        tot_error = tot_error + CalculateError(v_t, p_t);
        tot_cmatrix = tot_cmatrix + ConfusionMatrix(v_t, p_t);
    end
    
    avg_error = tot_error / NUM_FOLDS();
    avg_confusion_matrix = tot_cmatrix / NUM_FOLDS();
    avg_metrics = ClassificationMetrics(avg_confusion_matrix);
end

