function [ network, all_x, all_y ] = NeuralNetwork(training_examples, training_targets, validation_examples, validation_targets, nodes, trainFnc)
    num_epochs = 25000;
    [t_x, t_y] = ANNdata(training_examples, training_targets);
    [v_x, v_y] = ANNdata(validation_examples, validation_targets);
    
    all_x = [t_x v_x];
    all_y = [t_y v_y];
    
    network = feedforwardnet(nodes, trainFnc);
    network = configure(network, all_x, all_y);
    network.trainParam.epochs = num_epochs;
    network.divideFcn = 'divideind';
    network.divideParam.trainInd = 1:numel(t_x(1, :));
    network.divideParam.valInd = (numel(t_x(1, :)) + 1):numel(all_x(1, :));
    network.divideParam.testInd = [];
end

