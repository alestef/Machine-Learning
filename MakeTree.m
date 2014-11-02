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
    
    %WARNING: EXTREMELY HACKY AND NON-OPTIMAL SOLUTION
    %There is a bug where I'll get a long chain of choices that all lead
    %only to one value. To prevent this, I prune the tree as I go along. I
    %don't actually know why that happens.
    if (isequal(result.kids{1}.class,1)) && (isequal(result.kids{2}.class,1))
        result.op = [];
        result.kids = [];
        result.class = 1;
    elseif(isequal(result.kids{1}.class,0)) && (isequal(result.kids{2}.class,0))
        result.op = [];
        result.kids = [];
        result.class = 0;
    end
    %End of hacky segment.
    
end

end