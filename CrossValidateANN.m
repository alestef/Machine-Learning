function [ avg_error, avg_confusion_matrix, avg_metrics ] = CrossValidateANN(data_set) 
    load(data_set);
    [train_x, train_t, validation_x, validation_t] = Fold(1, x, y);
    tot_error = 0;
    tot_cmatrix = zeros(6, 6);
    for i = 1:NUM_FOLDS()
        [f_x, f_t, v_x, v_t] = Fold(i, train_x, train_t);
        
        % TODO(ticktakashi): Find optimal parameters.
        % 1. Split t_x into training_t_x and validation_t_x.
        % 2. Use train different nets by varying these parameters.
        %   a. trainFnc & trainFnc parameters [Automatically Done by TBox?]
        %   b. layers & nodes per layer
        %   c. number of epochs [Automatically Done by TBox?]
        % 3. Compare the performance of these nets [by error rate?].
        % 4. Select the best combination of parameters.
        % NOTE: The toolbox will automatically divide the data, we need
        %       to prevent this and supply our own.
        
        % NOTE: We assume that 1 hidden layer is sufficient and optimal, 
        %       since more than that would make this as a "Deep" network
        %       that we cannot train without smart weight initialization.
        % Calculate optimal number of nodes in layer
        [~, node_number] = CalculateOptimalNumNodes(f_x, f_t, validation_x, validation_t);
        
        trainFnc = 'trainlm';
        % TODO(ticktakashi): Find optimal function and function params
        [net, a, b] = NeuralNetwork(f_x, f_t, validation_x, validation_t, node_number, trainFnc);
        net = train(net, a, b);
        p_t = TestANN(net, v_x);
        tot_error = tot_error + CalculateError(v_t, p_t);
        tot_cmatrix = tot_cmatrix + ConfusionMatrix(v_t, p_t);
    end
    
    avg_error = tot_error / NUM_FOLDS();
    avg_confusion_matrix = tot_cmatrix / NUM_FOLDS();
    avg_metrics = ClassificationMetrics(avg_confusion_matrix);
end

