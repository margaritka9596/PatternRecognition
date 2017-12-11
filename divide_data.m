function [train_data, train_class, test_data, test_class] = divide_data(data, output, train_part)
%Divide_data: test and train sets for the given data
%
%   matObj = divide_data (A, array, Z) creates matrices with the data and classes values for both train and test cases.
%
%   Example:
%      divide_data(data, output, 0.8)
%      [train_data, train_class, test_data, test_class] = divide_data(data, output, train_part)
%
%   Input Arguments:
%      A - Input Matrix, dataset with features and values.
%      Array - shows the way how should the output look like (i.e. size)
%      Z - number, is equal to ratio of the train data (1-Z is the % of test data). Is equal to number between 0 and 1.
%
%   Output Arguments:
%      Train_data: matrix of the train data values
%      Train_class: matrix of the classes values on train
%      Test_data: matrix of the test data values
%      Test_class: matrix of the classes values on test 

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

