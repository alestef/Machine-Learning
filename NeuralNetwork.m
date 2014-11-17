function [ network ] = NeuralNetwork(examples, targets, layers, trainFnc, num_epochs)
    [x2, y2] = ANNdata(examples, targets);
   
    network = feedforwardnet(layers, trainFnc);
    network.trainParam.epochs = num_epochs;
    network = configure(network, x2, y2);
    network = train(network, x2, y2);
end

