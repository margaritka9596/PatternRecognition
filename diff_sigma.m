function [res] = diff_sigma(a, v)
    res =  (a * exp(-a * v)) / (1 + exp(-a * v))^2;
end

