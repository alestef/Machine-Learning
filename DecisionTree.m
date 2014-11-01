function result = DecisionTree()

load('cleandata_students.mat');

label = 1;

targets = zeros(1,1004);

for i=1:numel(y),
    if(y(i) == label)
        targets(i) =  1;
    end
end

attributes = (1:45);

result = MakeTree(x,attributes,targets);

end
