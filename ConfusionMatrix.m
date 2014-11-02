function cmatrix = ConfusionMatrix;

load 'cleandata_students.mat';

T = struct('t',{[],[],[],[],[],[],[]});

cutoff = round(numel(y)/10)*9;

training_examples = x([1:cutoff],:);

training_targets = y([1:cutoff]);
real_targets = y([cutoff+1:numel(y)]);

for i=1:6 
    T(i).t = DecisionTree(i, training_examples, training_targets);
end

predictions = testTrees(T,x);

cmatrix = zeros(6,6);

for i=1:numel(real_targets)
    cmatrix(real_targets(i), predictions(i)) = cmatrix(real_targets(i), predictions(i)) + 1;
end

