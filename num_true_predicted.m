function [] = num_true_predicted(expected, result)
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
    disp("True predicted (%)= "); disp(cnt_true * 100 / n);
    disp("False predicted (%)= "); disp(cnt_false * 100 / n);
end

