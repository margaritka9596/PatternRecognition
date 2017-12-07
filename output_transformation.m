function [newY0] = output_transformation(y0)
    n = size(y0, 1);
    newY0 = zeros(size(y0));
    for i = 1 : n 
        [~, ind] = max(y0(i, :));
        %[~, ind] = min(y0(i, :));
        newY0(i, ind) = 1; 
    end
end

