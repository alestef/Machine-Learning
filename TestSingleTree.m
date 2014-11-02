function [binary_label, depth] = TestSingleTree(tree, example, given_depth)

[binary_label, depth] = SingleTreeHelper(tree, example, given_depth);

end


function [binary_label, depth] = SingleTreeHelper(tree, example, given_depth)
    while ~(isempty(tree.op))
        attribute = example(tree.op);
            SingleTreeHelper(tree.kids{attribute+1}, example, given_depth+1);
    end
    
    binary_label = tree.class;
    depth = given_depth;
end
    