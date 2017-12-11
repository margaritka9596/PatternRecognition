function [y0] = test_net(X, numHiddenNeurons, w01, w12, a)
%Test_net implemented forward step of training algorithm 
%   Does it for given samples using evaluated weights from the train_net
%
%   Example:
%      y0_1 = test_net(train_data, n_hidden, w01, w12, a);
%
%   Input Arguments:
%      Train_data: matrice of the train data values
%      numHiddenNeurons: amount of hidden neurons
%      W01: weights for edges from input to first layer
%      W12: weights for edges from first layer to output one
%      A: Value of the sigma function
%
%   Output Arguments:
%      Y0_1: results from the output layer

    numSamples = size(X, 1);
    numInputs = size(X, 2);

    numOutputNeurons = 10; %second layer

    % Initialize the bias (weights of each neuron)
    bias = -1 * ones(2, max(numHiddenNeurons, numOutputNeurons));    %2 - num of layers    

    % Calculate weights randomly using seed.
    rand('state', sum(100 * clock));
    numInputsWithBias = numInputs + 1;
    numHiddenNeurWithBias = numHiddenNeurons + 1;

    H = zeros(numHiddenNeurons, 1);
    X1 = zeros(numHiddenNeurons, 1);
    X2 = zeros(numOutputNeurons, 1);

    y0 = zeros(numSamples, numOutputNeurons);   %output layer
    for j = 1 : numSamples
        % Hidden layer
        for s = 1 : numHiddenNeurons
          H(s) = bias(1, s) * w01(s, 1);
          for k = 2 : numInputsWithBias
            H(s) = H(s) + X(j, k - 1) * w01(s, k);
          end

          % Send data through sigmoid function 1/1+e^-ax
          X1(s) = sigma(a, H(s)); 
        end

        % Output layer
        for s = 1 : numOutputNeurons
          X2(s) = bias(2, s) * w12(s, 1);
          for k = 2 : numHiddenNeurWithBias
              X2(s) = X2(s) + X1(k - 1) * w12(s, k);
          end
          y0(j,s) = sigma(a, X2(s));
        end 
    end
%save('y0_test.mat','y0');
end