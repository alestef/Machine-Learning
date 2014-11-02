function result = MakeTree(examples, attributes, targets)

result = struct('kids',[],'op',[],'class',[]);

%Case that all examples are positive/negative for the training set
if not(any(targets))
    result.class = 0;
    return;
    
elseif all(targets)
    result.class = 1;
    return;

%Case that there is no more attributes left to split on
elseif isempty(attributes)
    result.class = mode(targets);
    return;

else
    best_attribute = ChooseAttribute(examples, attributes, targets);
    result.op = best_attribute;
    result.kids = cell(1,2);
    result.kids{1} = struct('kids',[],'op',[],'class',[]);
    result.kids{2} = struct('kids',[],'op',[],'class',[]);
    
    new_attr = attributes(attributes ~= best_attribute);
    
    for i=0:1
        idx = examples(:,best_attribute) == i; %Picks appropriate rows
        new_examples = examples(idx,:);
        new_targets = [targets(idx)];
        
        if isempty(new_examples)
            result.kids{i+1}.class = mode(targets);
        else
            result.kids{i+1} = MakeTree(new_examples, new_attr, new_targets);
        end
    end
end

end