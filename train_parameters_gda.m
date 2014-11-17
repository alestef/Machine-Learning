function [ optimal_gda_network, best_lr_dec, best_lr_inc ] = train_parameters_gda( t_x, t_t, v_x, v_t, nodes, best_lr )  
   
lower = 1.0;
    upper = 1.5;
    best_lr_inc = upper;
    retrainU = 1;
    retrainL = 1;
    predictionsL = [];
    predictionsU = [];
    
    for i = 1:10 
        if(retrainL)
            [networkL, aL, bL] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingda');
            networkL.trainParam.lr_inc = lower;
            networkL = train(networkL, aL, bL); 
            predictionsL = TestANN(networkL, v_x);
        end
        
        if(retrainU)
            [networkU, aU, bU] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingda');
            networkU.trainParam.lr_inc = upper;
            networkU = train(networkU, aU, bU); 
            predictionsU = TestANN(networkU, v_x);
        end
        
        if(CalculateError(v_t, predictionsL) <= CalculateError(v_t, predictionsU))
            upper = (upper+lower)/2;
            best_lr_inc = lower;
            retrainU = 1;
            retrainL = 0;
        else 
            lower= (upper+lower)/2;
            best_lr_inc = upper;
            retrainU = 0;
            retrainL = 1;
        end
    end
    
    
    lower = 0.5;
    upper = 1.0;
    best_lr_dec = upper;
    retrainU = 1;
    retrainL = 1;
    predictionsL = [];
    predictionsU = [];
    
    for i = 1:10 
        if(retrainL)
            [networkL, aL, bL] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingda');
            networkL.trainParam.lr_dec = lower;
            networkL = train(networkL, aL, bL); 
            predictionsL = TestANN(networkL, v_x);
        end
        
        if(retrainU)
            [networkU, aU, bU] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingda');
            networkU.trainParam.lr_dec = upper;
            networkU = train(networkU, aU, bU); 
            predictionsU = TestANN(networkU, v_x);
        end
        
        if(CalculateError(v_t, predictionsL) <= CalculateError(v_t, predictionsU))
            upper = (upper+lower)/2;
            best_lr_dec = lower;
            retrainU = 1;
            retrainL = 0;
        else 
            lower= (upper+lower)/2;
            best_lr_dec = upper;
            retrainU = 0;
            retrainL = 1;
        end
    end
    
    [optimal_gda_network, gda_x, gda_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingda');
    optimal_gda_network.trainParam.lr_inc = best_lr_inc;
    optimal_gda_network.trainParam.lr_dec = best_lr_dec;
    optimal_gda_network.trainParam.lr = best_lr;
    optimal_gda_network = train(optimal_gda_network, gda_x, gda_y); 
end
