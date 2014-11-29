function [ au_vec ] = AUVector( binary_vec )
    count = sum(binary_vec);
    au_vec = zeros(1, count);
    iter = 1;
    for i=1:numel(binary_vec)
        if (binary_vec(i) == 1)
            au_vec(iter) = i;
            iter = iter + 1;
        end
    end
end

