function [ avg_error, avg_confusion_matrix, avg_metrics, optimal_network, opt_err ] = CrossValidateANN(data_set) 
    load(data_set);
    [train_x, train_t, validation_x, validation_t] = Fold(1, x, y);
    tot_error = 0;
    tot_cmatrix = zeros(6, 6);
    optimal_networks = zeros(NUM_FOLDS(), 1);
    optimal_network_errors = zeroes(NUM_FOLDS(), 1);
    for i = 1:NUM_FOLDS()
        [f_x, f_t, v_x, v_t] = Fold(i, train_x, train_t);
        
        % NOTE: We assume that 1 hidden layer is sufficient and optimal, 
        %       since more than that would make this as a "Deep" network
        %       that we cannot train without smart weight initialization.
        % Calculate optimal number of nodes in layer
        [~, node_number] = CalculateOptimalNumNodes(f_x, f_t, validation_x, validation_t);
        
        [gd_net, gd_error, lr] = train_parameters_gd(f_x, f_t, validation_x, validation_t, node_number);
        [gda_net, gda_error, ~, ~] = train_parameters_gda(f_x, f_t, validation_x, validation_t, node_number, lr);
        [gdm_net, gdm_error, ~] = train_parameters_gdm(f_x, f_t, validation_x, validation_t, node_number, lr);
        
        % next optimal
        optimal_net = gd_net;
        optimal_net_error = gd_error;
        
        if (gda_error < optimal_net_error)
            optimal_net = gda_net;
            optimal_net_error = gda_error;
        end
        
        if (gdm_error < optimal_net_error)
            optimal_net = gdm_net;
            optimal_net_error = gdm_error;
        end
        
        optimal_networks(i) = optimal_net;
        optimal_network_errors(i) = CalculateError(v_t, p_t);
        tot_error = tot_error + optimal_network_errors(i);
        tot_cmatrix = tot_cmatrix + ConfusionMatrix(v_t, p_t);
    end
    
    [opt_err, best_net_index] = min(optimal_network_errors);
    optimal_network = optimal_networks(best_net_index);
    avg_error = tot_error / NUM_FOLDS();
    avg_confusion_matrix = tot_cmatrix / NUM_FOLDS();
    avg_metrics = ClassificationMetrics(avg_confusion_matrix);
end

