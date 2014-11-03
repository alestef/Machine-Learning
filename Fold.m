function [ t_set, t_targets, v_set, v_targets ] = Fold(i, all, targets)
    NUM_FOLDS = 10;
    fold_size = numel(targets) / NUM_FOLDS;
    t_set = [];
    t_targets = [];
    
    if (i ~= 1)
        t_set = all(1 : ((i-1) * fold_size), :);
        t_targets = targets(1 : ((i-1) * fold_size));
    end
    
    if (i ~= NUM_FOLDS)
        t_set = [t_set; all((i * fold_size):numel(targets), :)];
        t_targets = [t_targets; targets((i * fold_size):numel(targets))];
    end
    
    v_set = all(((i-1) * fold_size + 1):(i * fold_size - 1), :);
    v_targets = targets(((i-1) * fold_size + 1):(i * fold_size - 1));
end

