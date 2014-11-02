function result = DecisionTree(label_given)

load('noisydata_students.mat');

label = label_given;

targets = zeros(1,numel(y));

for i=1:numel(y),
    if(y(i) == label)
        targets(i) =  1;
    end
end

attributes = (1:45);

result = MakeTree(x,attributes,targets);

end
