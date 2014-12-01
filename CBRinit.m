function [ cbr ] = CBRinit(x, y)
    % Create the first case and bucket.
    au_vec = AUVector(x(1, :));
    first_case =  assignCase(au_vec, y(1)); 
    first_bucket = struct('origin', first_case, 'elements', first_case);
    
    % Initialize the CBR struct, a list of buckets.
    cbr = struct();
    cbr.radius = 0.50;
    cbr.buckets = first_bucket;
    cbr.measure = 'length';
    cbr.k = 10;
    
    % Add all cases (created from x and y) to this CBR
    for i=2:numel(x(:, 1))
        a_vec = AUVector(x(i, :));
        new_case = assignCase(a_vec, y(i));
        cbr = Retain(cbr, new_case);
    end
    
    flat = struct('id', {}, 'problem', {}, 'typicality', {}, 'solution', {});
    for i=1:numel(cbr.buckets)
        flat = [flat, cbr.buckets(i).elements];
    end
    flat = RemoveDuplicateCases(flat);
    cbr.flat_initial_storage = flat;
end

