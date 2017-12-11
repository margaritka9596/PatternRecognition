function [newY0] = output_transformation_to_one_vec(y0)
    n = size(y0, 1);
    newY0 = zeros(n, 1);
    for i = 1 : n 
        [~, ind] = max(y0(i, :));
        newY0(i) = ind - 1; 
    end
end
