function [w01, w12] = train_net(X, y, coeff, a, numHiddenNeurons, n_epoch)
%train_net Weights for the neural network. 
%   train_net(train_data, train_class, l_rate, a, n_hidden, n_epoch) gives
%   weights to parameters.
%
%   Example:
%      [w01, w12] = train_net(train_data, train_class, l_rate, a, n_hidden, n_epoch)
%
%   Input Arguments:
%      Train_data: matrix of the train data values
%      Train_class: matrix of the classes values on train
%      L_rate: value of the learning rate
%      A: valuealue of the sigma function
%      N_hidden: amount of hidden layers
%      N_epoch: amount of iterations
%
%   Output Arguments:
%      w01: weights for edges from input to first layer
%      w12: weights for edges from first layer to output one

    numSamples = size(X, 1);
    numInputs = size(X, 2);
    
    numOutputNeurons = 10; %second(output) layer
    
    %Initialize the bias (weights of each neuron)
    bias = -1 * ones(2, max(numHiddenNeurons, numOutputNeurons));    %2 - num of layers
    
    %Calculate weights randomly using seed.
    rand('state', sum(100 * clock));
    numInputsWithBias = numInputs + 1;
    numHiddenNeurWithBias = numHiddenNeurons + 1;
    %w01 = (-1 + 2 .* rand(numHiddenNeurons, numInputsWithBias)) / (2 * numSamples); %weights for edges from input to first layer | +1 for bias
    %w12 = (-1 + 2 .* rand(numOutputNeurons, numHiddenNeurWithBias)) / (2 * numHiddenNeurons); %weights for edges from first layer to output one |+1 for bias
    
    w01 = -1 + 2 .* rand(numHiddenNeurons, numInputsWithBias); %weights for edges from input to first layer | +1 for bias
    w12 = -1 + 2 .* rand(numOutputNeurons, numHiddenNeurWithBias); %weights for edges from first layer to output one |+1 for bias
    
    H = zeros(numHiddenNeurons, 1);
    X1 = zeros(numHiddenNeurons, 1);
    X2 = zeros(numOutputNeurons, 1);
     
    deltaOutput = zeros(numOutputNeurons, 1);
    deltaHidden = zeros(numHiddenNeurons, 1);
    
    % Initialisation
    QprevEpoch = 0;
    QcurEpoch = 0;
    QcurEpochVec = rand(numSamples, 1) * 2 - 1; %����� ���� ����� ������ ���������?
    QEpochs = zeros(1, n_epoch);
    eps = 10^-6;
    
    i = 1;
    while 1
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
              y0(j, s) = sigma(a, X2(s));
            end

            % Adjust delta values of weights
            % For output layer:
            % delta(wi) = xi * delta,
            % delta = k * actual output * (1 - actual output) * (desired
            % output - actual output) | k from sigma function

            QcurEpochVec(j) = 0;
            for k = 1 : numOutputNeurons
                deltaOutput(k) = y0(j, k) * (1 - y0(j, k)) * (y(j, k) - y0(j, k)); %j� sample ��� ���� �����
                %deltaOutput(k) = y0(j, k) * diff_sigma(a, y0(j, k)) * (y(j, k) - y0(j, k)); %j� sample ��� ���� �����
                %�������������������� ������
                QcurEpochVec(j) = QcurEpochVec(j) + (y(j, k) - y0(j, k))^2;
            end
            
            % Propagate the delta backwards into hidden layers
            for k = 1 : numHiddenNeurons
              sum1 = 0;
              for s = 1 : numOutputNeurons
                 %  * ����� ����� ����������� �� ���� ��������� ���� � �������(��� ,,-" � �������� �������)
                 sum1 = sum1 + deltaOutput(s) * w12(s, k + 1); %k+1 ������ ��� � 1� ��� �����
              end
              deltaHidden(k) = X1(k) * (1 - X1(k)) * sum1; % netpj * ����������� ����� ������� * sum
              %deltaHidden(k) = X1(k) * diff_sigma(a, X1(k)) * sum1; % netpj * ����������� ����� ������� * sum
            end

            % Add weight changes to original weights 
            % And use the new weights to repeat process.
            % delta weight = coeff * x * delta
            % correction of weights
            %tau = 0.2;
            %regular = (1 + coeff * tau);
            %%!
            regular = 1;
            for k1 = 1 : numHiddenNeurons
                %bias
                w01(k1, 1) =  w01(k1, 1) * regular + coeff * bias(1, k1) * deltaHidden(k1);
                %hidden neurons
                for k2 = 2 : numInputsWithBias
                   w01(k1, k2) =  w01(k1, k2)* regular + coeff * X(j, k2 - 1) * deltaHidden(k1);
                end
            end
            for k2 = 1 : numOutputNeurons
                %bias
                   w12(k2, 1) = w12(k2, 1)* regular + coeff * bias(2, k2) * deltaOutput(k2);
                for k1 = 2 : numHiddenNeurWithBias
                   w12(k2, k1) = w12(k2, k1)* regular + coeff * X1(k1 - 1) * deltaOutput(k2);
                end          
            end
       end
      %___________________________________________________________________
      QcurEpoch = sum(QcurEpochVec) / (2 * numSamples);
      %disp(QcurEpoch);
      if (mod(i, 5) == 0)       %Plot convergence, but not for every epoch
        semilogy(1 : i, QEpochs(1 : i));
        title(sprintf('Convergence (epoch %d)', i));
        drawnow;
      end

      if QcurEpoch < 0.05 % if the learning is good enough
          disp('the learning is good enough');
          %disp(QEpochs(1:i));
          %save('y.mat','y');
          %save('y0.mat','y0');
          break;
      end

      if i >= n_epoch %if too many epochs would be done
        disp('end by num of epochs was done');
        %disp(QEpochs(1:i));
        %save('y.mat','y');
        %save('y0.mat','y0');
        break;
      end

      if i > 1 % if this is not the first epoch
        if abs(QcurEpoch - QprevEpoch) < eps        %the improvement is small enough
            disp('the improvement is small enough');
            %disp(QprevEpoch); disp(QcurEpoch);
            %disp(QcurEpoch - QprevEpoch);
            %disp(QEpochs(1:i));
            %disp(QEpochs);
            %save('y.mat','y');
            %save('y0.mat','y0');
          break;
        end
      end
     
     QEpochs(i) = QcurEpoch;
     QprevEpoch = QcurEpoch;
     
     %Shuffling input data samples
     ind = randperm(numSamples);
     y = y(ind, :);
     X = X(ind, :);

     disp(i);
     i = i + 1;    
    end
%save('w01.mat','w01');
%save('w12.mat','w12');
disp('End of training');
end
