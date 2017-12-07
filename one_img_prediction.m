function [y0] = one_img_prediction(X, numHiddenNeurons, w01, w12, a)
    numInputs = size(X, 2);

    %numHiddenNeurons = 2; %first layer
    numOutputNeurons = 10; %second layer

    % Initialize the bias (weights of each neuron)
    bias = ones(2, max(numHiddenNeurons, numOutputNeurons));    %2 - num of layers
    bias = -1 * bias;

    % Calculate weights randomly using seed.
    numInputsWithBias = numInputs + 1;
    numHiddenNeurWithBias = numHiddenNeurons + 1;

    H = zeros(numHiddenNeurons, 1);
    X1 = zeros(numHiddenNeurons, 1);
    X2 = zeros(numOutputNeurons, 1);

    y0 = zeros(1, numOutputNeurons);   %output layer
    % Hidden layer
    for s = 1 : numHiddenNeurons
      H(s) = bias(1, s) * w01(s, 1);
      for k = 2 : numInputsWithBias
        H(s) = H(s) + X(k - 1) * w01(s, k);
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
      y0(s) = sigma(a, X2(s));
    end
end