function [train_data, train_class, test_data, test_class] = divide_data(data, output)
    n = size(data, 1);
    
    train_size = int32(0.7 * n);
    test_size = int32(0.3 * n);
    
    train_data = zeros(train_size, size(data, 2));
    test_data = zeros(test_size, size(data, 2));
    
    train_class = zeros(train_size, 10);
    test_class = zeros(test_size, 10);
    
    train_k = 1;
    test_k = 1;
    
    for i = 1 : n
        num = mod(i, 100);
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

