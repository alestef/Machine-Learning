function [ optimal_gd_network, best_lr ] = train_parameters_gd( t_x, t_t, v_x, v_t, nodes )  
    lower = 0.0;
    upper = 1.0;
    best_lr = upper;
    retrainU = 1;
    retrainL = 1;
    predictionsL = [];
    predictionsU = [];
    
    for i = 1:10 
        if(retrainL)
            [networkL, aL, bL] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingd');
            networkL.trainParam.lr = lower;
            networkL = train(networkL, aL, bL); 
            predictionsL = TestANN(networkL, v_x);
        end
        
        if(retrainU)
            [networkU, aU, bU] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingd');
            networkU.trainParam.lr = upper;
            networkU = train(networkU, aU, bU); 
            predictionsU = TestANN(networkU, v_x);
        end
        
        if(CalculateError(v_t, predictionsL) <= CalculateError(v_t, predictionsU))
            upper = (upper+lower)/2;
            best_lr = lower;
            retrainU = 1;
            retrainL = 0;
        else 
            lower= (upper+lower)/2;
            best_lr = upper;
            retrainU = 0;
            retrainL = 1;
        end
    end
    
    [optimal_gd_network, gd_x, gd_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingd');
    optimal_gd_network.trainParam.lr = best_lr;
    optimal_gd_network = train(optimal_gd_network, gd_x, gd_y);

    
end