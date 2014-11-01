function result = MakeTree(examples, attributes, targets)

result = struct('kids',[],'op',[],'class',[]);

%Case that all examples are positive/negative for the training set
if isequal(examples,targets)
    result.class = targets(1);
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
    
    new_examples = [];
    new_targets = [];
    new_attr = attributes(attributes ~= best_attribute);
    
    for i=0:1
        for j=1:numel(targets)
            if examples(j,best_attribute) == i
                new_examples = [new_examples;examples(j,:)];
                new_targets = [new_targets;targets(j)];
            end
        end
        
        if isempty(new_examples)
            result.kids{i+1}.class = mode(targets);
            return;
        else
            result.kids{i+1} = MakeTree(new_examples, new_attr, new_targets);
            return;
        end
        
        new_examples = [];
        new_targets = [];
    end
    
    %for i=1:numel(targets)
    %    if examples(i,best_attribute) == 0;
    %        Negative_examples = [examples(i,:);Negative_examples];
    %        Negative_targets = [targets(i);Negative_targets];
    %        %Consider preallocation (trade space for speed)
    %    else
    %        Positive_examples = [examples(i,:);Positive_examples];
    %        Positive_targets = [targets(i);Positive_targets];
    %        %Consider preallocation (trade space for speed)
    %    end
    %end

    
    %Negative branch
    %if isempty(Negative_examples)
    %    result.kids{1}.class = mode(targets);
    %else
    %    result.kids{1} = MakeTree(Negative_examples, new_attr, Negative_targets);
    %end
    
    %Positive Branch
    %if isempty(Positive_examples)
    %    result.kids{2}.class = mode(targets);
    %    return;
    %else
    %    result.kids{2} = MakeTree(Positive_examples, new_attr, Positive_targets);
    %    return;
    %end
end

end