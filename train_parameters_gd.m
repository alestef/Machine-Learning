function [ optimal_gd_network, err, best_lr ] = train_parameters_gd( t_x, t_t, v_x, v_t, nodes )  
    lower = 0.0001;
    upper = 0.1;
    NUM_STEPS = 1000;
    step_size = (upper - lower) / NUM_STEPS;
    errors = zeros(NUM_STEPS, 1);
    
    for i = 1:NUM_STEPS
        [network, a, b] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingd');
        network.trainParam.lr = ((i - 1) * step_size) + lower;
        network = train(network, a, b);
        predictions = TestANN(network, v_x);
        errors(i) = CalculateError(v_t, predictions);
    end
    
    [err, min_index] = min(errors);
    
    best_lr = ((min_index - 1) * step_size) + lower;
        
    [optimal_gd_network, gd_x, gd_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingd');
    optimal_gd_network.trainParam.lr = best_lr;
    optimal_gd_network = train(optimal_gd_network, gd_x, gd_y);
end