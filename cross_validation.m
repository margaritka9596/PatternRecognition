function [] = cross_validation(X, labels, n_hidden, w01, w12, a)
    classes = output_transformation_to_one_vec(labels);
    N = 10;
    indices = crossvalind('Kfold', classes, N);
    
    %Parametres for net 
    l_rate = 0.1;   %learning coefficient
    n_epoch = 200;
    %only one hiden layer exist
    n_hidden = 16;  %num of neurons in hidden layer
    a = 0.3;        %coeff for sigma function

    trues= [];
    falses = [];
    for i = 1 : N
        test_ind = (indices == i);
        train_ind = ~test_ind;
        %class = classify(X(test_ind, :), X(train_ind, :), labels(train_ind, :));
        train_data = X(train_ind, :);
        train_label= labels(train_ind, :);
        test_data = X(test_ind, :);
        test_label = labels(test_ind, :);
        
        %Training net on train data
        [w01, w12] = train_net(train_data, train_label, l_rate, a, n_hidden, n_epoch);

        y0_1 = test_net(test_data, n_hidden, w01, w12, a);
        newY0_1 = output_transformation(y0_1);
        
        [true_pred,false_pred] = num_true_predicted(newY0_1, test_label);
        trues = [trues  true_pred];
        falses = [falses  false_pred];
    end   
    
    disp("Final True predicted (%)= "); disp(mean(trues));
    disp("Final False predicted (%)= "); disp(mean(falses));
end
