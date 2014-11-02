function result = DecisionTree(label, examples, real_targets)


targets = zeros(1, numel(real_targets));

for i=1:numel(targets),
  if(real_targets(i) == label)
    targets(i) =  1;
  end
end

attributes = (1:45);

result = MakeTree(examples, attributes, targets);

end
