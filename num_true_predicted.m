function [out_true,out_false] = num_true_predicted(expected, result)
%Num_true_predicted: percent of true and false predictions
%
%   Example: num_true_predicted(expected, result)
%
%   Input Arguments:
%      Expected: matrix with results get from the training data
%      Results: matrix with real results
%
%   Output Arguments: 
%      Cnt_true: percent of true predictions
%      Cnt_false: percent of false predictions

    n = size(expected, 1);
    cnt_true = 0;
    cnt_false = 0;
    for i = 1 : n
        if(expected(i, :) == result(i, :))
            cnt_true = cnt_true + 1;
        else
            cnt_false = cnt_false + 1;
        end
    end
    out_true = cnt_true * 100 / n;
    out_false = cnt_false * 100 / n;
    disp("True predicted (%)= "); disp(out_true);
    disp("False predicted (%)= "); disp(out_false);
end

