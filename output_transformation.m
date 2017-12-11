function [newY0] = output_transformation(y0)
%Output_transformation: transformed values from the output layer
%   NewY0_2 = output_transformation(y0_2) is the matrix with 1 or 0 in
%   each cell.
%
%   Example: newY0_2 = output_transformation(y0_2)
%
%   Input Arguments:
%      Y0: matrix with results from the output layer (values are in range from 0 to 1)
%
%   Output Arguments:
%      newY0: matrix with results from the output layer after transformation (values are equal to 0 or 1)

    n = size(y0, 1);
    newY0 = zeros(size(y0));
    for i = 1 : n 
        [~, ind] = max(y0(i, :));
        newY0(i, ind) = 1; 
    end
end

