function [ predictions ] = TestANN(network, examples)
    transposed_examples = examples';
    nn_out = sim(network, transposed_examples);
    predictions = NNout2labels(nn_out);
end