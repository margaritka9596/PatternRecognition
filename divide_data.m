function [train_data, train_class, test_data, test_class] = divide_data(data, output, train_part)
    n = size(data, 1);
    test_part = 1 - train_part;
    train_size = int32(train_part * n);
    test_size = int32(test_part * n);
    
    train_data = zeros(train_size, size(data, 2));
    test_data = zeros(test_size, size(data, 2));
    
    train_class = zeros(train_size, 10);
    test_class = zeros(test_size, 10);
    
    train_k = 1;
    test_k = 1;
    
    for i = 1 : n
        if(mod(i, 100) < train_size / 10)
            train_data(train_k, :) = data(i, :);
            train_class(train_k, :) = output(i, :);
            train_k = train_k + 1;
        else
            test_data(test_k, :) = data(i, :);
            test_class(test_k, :) = output(i, :);
            test_k = test_k + 1;
        end
    end
end

