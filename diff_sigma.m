function [res] = diff_sigma(v)
    %a = 5.3;
    a = 1;
    res =  a * exp(-a * v) / (1 + exp(-a * v))^2;
end

