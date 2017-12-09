%there are different values in the output vector from the net
%we need to transform it to the view where 1 is in the place of maximum
%value in vector and zero otherwise
function [newY0] = output_transformation(y0)
    n = size(y0, 1);
    newY0 = zeros(size(y0));
    for i = 1 : n 
        [~, ind] = max(y0(i, :));
        newY0(i, ind) = 1; 
    end
end

