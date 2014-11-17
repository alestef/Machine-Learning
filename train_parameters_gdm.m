function [ optimal_gdm_network, best_mc ] = train_parameters_gdm( t_x, t_t, v_x, v_t, nodes, best_lr )  
    lower = 0.75;
    upper = 0.99;
    NUM_STEPS = 1000;
    step_size = (upper - lower) / NUM_STEPS;
    errors = zeros(NUM_STEPS, 1);
    
    for i = 1:NUM_STEPS
        [network, a, b] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingdm');
        network.trainParam.lr = best_lr;
        network.trainParam.mc = ((i - 1) * step_size) + lower;
        network = train(network, a, b);
        predictions = TestANN(network, v_x);
        errors(i) = CalculateError(v_t, predictions);
    end
    
    [~, min_index] = min(errors);
    
    best_mc = ((min_index - 1) * step_size) + lower;
        
    [optimal_gdm_network, gd_x, gd_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingdm');
    optimal_gdm_network.trainParam.lr = best_lr;
    optimal_gdm_network.trainParam.mc = best_mc;
    optimal_gdm_network = train(optimal_gdm_network, gd_x, gd_y);
end
