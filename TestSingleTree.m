function [binary_label, depth] = TestSingleTree(tree, example)

[binary_label, depth] = SingleTreeHelper(tree, example, 0);

end


function [binary_label, depth] = SingleTreeHelper(tree, example, given_depth)
    if isempty(tree.class)
        attribute = example(tree.op);
            SingleTreeHelper(tree.kids{attribute+1}, example, given_depth+1);
    end
    
    binary_label = tree.class;
    depth = given_depth;
end
    