function [ min_error, num_nodes ] = CalculateOptimalNumNodes(t_x, t_t, v_x, v_t)
    errors = zeros(50, 1);
    for i = 1:numel(errors)
        [network, a, b] = NeuralNetwork(t_x, t_t, v_x, v_t, i, 'trainlm');
        network = train(network, a, b);
        predictions = TestANN(network, v_x);
        errors(i) = CalculateError(v_t, predictions);
    end
    
    [min_error, num_nodes] = min(errors);
end
