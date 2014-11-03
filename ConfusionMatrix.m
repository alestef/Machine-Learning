function cmatrix = ConfusionMatrix(real, pred)
    cmatrix = zeros(6, 6);
    for i=1:numel(real)
        cmatrix(real(i), pred(i)) = cmatrix(real(i), pred(i)) + 1;
    end
end

