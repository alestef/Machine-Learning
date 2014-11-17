    function [ optimal_nrp_network, err, best_delt_dec, best_delt_inc ] = train_parameters_nrp( t_x, t_t, v_x, v_t, nodes, best_lr, NUM_STEPS )  
    lower = 1.1;
    upper = 1.3;
    NUM_STEPS = 1000;
    step_size = (upper - lower) / NUM_STEPS;
    errors = zeros(NUM_STEPS, 1);
    
    for i = 1:NUM_STEPS
        [network, a, b] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'trainnrp');
        network.trainParam.delt_inc = ((i - 1) * step_size) + lower;
        network = train(network, a, b);
        predictions = TestANN(network, v_x);
        errors(i) = CalculateError(v_t, predictions);
    end
    
    [err, min_index] = min(errors);
    
    best_delt_inc = ((min_index - 1) * step_size) + lower;
        
    
    lower = 0.4;
    upper = 0.6;
    NUM_STEPS = 1000;
    step_size = (upper - lower) / NUM_STEPS;
    errors = zeros(NUM_STEPS, 1);
    
    for i = 1:NUM_STEPS
        [network, a, b] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'trainnrp');
        network.trainParam.delt_dec = ((i - 1) * step_size) + lower;
        network = train(network, a, b);
        predictions = TestANN(network, v_x);
        errors(i) = CalculateError(v_t, predictions);
    end
    
    [err, min_index] = min(errors);
    
    best_delt_dec = ((min_index - 1) * step_size) + lower;
    
    
    [optimal_nrp_network, gd_x, gd_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'trainnrp');
    optimal_nrp_network.trainParam.delt_dec = best_delt_dec;
    optimal_nrp_network.trainParam.delt_inc = best_delt_inc;
    optimal_nrp_network = train(optimal_nrp_network, gd_x, gd_y);
    err = CalculateError(v_t, TestANN(optimal_nrp_network, v_x));
end
