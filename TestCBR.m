function [ predictions ] = TestCBR(cbr, examples)
    predictions = zeros(numel(examples(:,1)), 1);

    for i = 1:numel(predictions)
        novel_case = assignCase(AUVector(examples(i,:)), 0);
        calculated_case = Retrieve(cbr, novel_case);
        predictions(i) = calculated_case.solution;
    end
end


