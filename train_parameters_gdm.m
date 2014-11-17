function [ optimal_gdm_network, best_mc ] = train_parameters_gdm( t_x, t_t, v_x, v_t, nodes, best_lr )  
 
    lower = 0.0;
    upper = 1.0;
    best_mc = upper;
    retrainU = 1;
    retrainL = 1;
    predictionsL = [];
    predictionsU = [];
    
    for i = 1:10 
        if(retrainL)
            [networkL, aL, bL] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingdm');
            networkL.trainParam.mc = lower;
            networkL = train(networkL, aL, bL); 
            predictionsL = TestANN(networkL, v_x);
        end
        
        if(retrainU)
            [networkU, aU, bU] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingdm');
            networkU.trainParam.mc = upper;
            networkU = train(networkU, aU, bU); 
            predictionsU = TestANN(networkU, v_x);
        end
        
        if(CalculateError(v_t, predictionsL) <= CalculateError(v_t, predictionsU))
            upper = (upper+lower)/2;
            best_mc = lower;
            retrainU = 1;
            retrainL = 0;
        else 
            lower= (upper+lower)/2;
            best_mc = upper;
            retrainU = 0;
            retrainL = 1;
        end
    end
    
    [optimal_gdm_network, gdm_x, gdm_y] = NeuralNetwork(t_x, t_t, v_x, v_t, nodes, 'traingdm');
    optimal_gdm_network.trainParam.mc = best_mc;
    optimal_gdm_network.trainParam.lr = best_lr;
    optimal_gdm_network = train(optimal_gdm_network, gdm_x, gdm_y); 
    
