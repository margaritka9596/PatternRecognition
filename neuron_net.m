function [] = neuron_net(X, y, coeff, numHiddenNeurons, n_epoch)
    numSamples = size(X, 1);
    numInputs = size(X, 2);
    
    %numHiddenNeurons = 3;  %first layer
    numOutputNeurons = 10; %second layer
    
    % Initialize the bias (weights of each neuron)
    bias = ones(2, max(numHiddenNeurons, numOutputNeurons));    %2 - num of layers
    bias = -1 * bias;
    
    % Number of learning n_epoch
   % n_epoch = 1000;
    
    % Calculate weights randomly using seed.
    rand('state', sum(100 * clock));
    numInputsWithBias = numInputs + 1;
    numHiddenNeurWithBias = numHiddenNeurons + 1;
    %w01 = -1 + 2 .* rand(numHiddenNeurons, numInputsWithBias) / (2 * numSamples); %weights for edges from input to first layer | +1 for bias
    %w12 = -1 + 2 .* rand(numOutputNeurons, numHiddenNeurWithBias) / (2 * numHiddenNeurons); %weights for edges from first layer to output one |+1 for bias
    
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
    eps = 10^-20;
    i = 1;
    %for i = 1 : n_epoch
    while 1
       y0 = zeros(numSamples, numOutputNeurons);   %output layer
       for j = 1 : numSamples
            % Hidden layer
            for s = 1 : numHiddenNeurons
              H(s) = bias(1, s) * w01(s, 1);
              for k = 2 : numInputsWithBias
                H(s) = H(s) + X(j, k - 1) * w01(s, k);
              end

              % Send data through sigmoid function 1/1+e^-x
              X1(s) = sigma(H(s)); 
            end

            % Output layer
            for s = 1 : numOutputNeurons
              X2(s) = bias(2, s) * w12(s, 1);
              for k = 2 : numHiddenNeurWithBias
                  X2(s) = X2(s) + X1(k - 1) * w12(s, k);
              end
              y0(j,s) = sigma(X2(s));
            end

            % Adjust delta values of weights
            % For output layer:
            % delta(wi) = xi * delta,
            % delta = k * actual output * (1 - actual output) * (desired
            % output - actual output) | k fromsigma function

            
            %%%%
            QcurEpochVec(j) = 0;
            for k = 1 : numOutputNeurons
                deltaOutput(k) = y0(j, k) * (1 - y0(j, k)) * (y(j, k) - y0(j, k)); %j� sample ��� ���� �����
                %deltaOutput(k) = y0(j, k) * diff_sigma(y0(j, k)) * (y0(j, k) - y(j, k)); %j� sample ��� ���� �����
                %�������������������� ������
                QcurEpochVec(j) = QcurEpochVec(j) + (y0(j, k) - y(j, k))^2;
            end
            QcurEpochVec(j) = QcurEpochVec(j) / 2;
            %disp('_________________________');
            
            
            %%%%%%%TODO futher
            %?? ��� ����� ����� �� ������, � ���� ��?
            %��� �������� �� ��������� ����
            % Propagate the delta backwards into hidden layers
            for k = 1 : numHiddenNeurons
              sum1 = 0;
              for s = 1 : numOutputNeurons
                 %  * ����� ����� ����������� �� ���� ��������� ���� � �������(��� ,,-" � �������� �������)
                 sum1 = sum1 + deltaOutput(s) * w12(s, k + 1); %k+1 ������ ��� � 1� ��� �����
              end
              deltaHidden(k) = X1(k) * (1 - X1(k)) * sum1; % netpj * ����������� ����� ������� * sum
              %deltaHidden(k) = X1(k) * diff_sigma(X1(k)) * sum1; % netpj * ����������� ����� ������� * sum
            end

            % Add weight changes to original weights 
            % And use the new weights to repeat process.
            % delta weight = coeff * x * delta
            % ������������� �����

            %bias
            w01(1, 1) =  w01(1, 1) + coeff * bias(1, 1) * deltaHidden(1);
            w01(2, 1) =  w01(2, 1) + coeff * bias(1, 2) * deltaHidden(2);
            %hidden neurons
            for k = 2 : numInputsWithBias
                w01(1, k) =  w01(1, k) + coeff * X(j, k - 1) * deltaHidden(1);
                w01(2, k) =  w01(2, k) + coeff * X(j, k - 1) * deltaHidden(2);
            end

            for k = 1 : numOutputNeurons
               %bias
               w12(k, 1) = w12(k, 1) + coeff * bias(2, k) * deltaOutput(k);
               %1 & 2 neur
               w12(k, 2) = w12(k, 2) + coeff * X1(1) * deltaOutput(k);
               w12(k, 3) = w12(k, 3) + coeff * X1(2) * deltaOutput(k);
            end          
       end
      %___________________________________________________________________
      QcurEpoch = sum(QcurEpochVec) / (2 * numSamples);
      %disp(QcurEpoch);
      if (mod(i, 50) == 0) % Plot convergence, but not for every epoch
        semilogy(1 : i, QEpochs(1 : i));
        title(sprintf('Convergence (epoch %d)', i));
        drawnow;
      end

      if QcurEpoch < 0.005 % the learning is good enough
          disp('the learning is good enough');
          break;
      end

      if i >= n_epoch % too many epochs would be done
        disp('end by num of epochs was done');
        break;
      end

      %{
      if i > 1 % this is not the first epoch
        if abs(QcurEpoch - QprevEpoch) < eps % the improvement is small enough
            disp('the improvement is small enough');
            disp(QprevEpoch); disp(QcurEpoch);
            disp(QcurEpoch - QprevEpoch);
            disp(QEpochs);
          break;
        end
      end
      %}
     QEpochs(i) = QcurEpoch;
     QprevEpoch = QcurEpoch;
     %___________________________________________________________________
     disp(i);
     i = i + 1;
     end
disp(QEpochs);
save('y0.mat','y0');
save('w01.mat','w01');
save('w12.mat','w12');
disp('End');
%%TODO
%{
y0(y0 > 0.5) = 1;
    y0(y0 <= 0.5) = 0;
    X = X';

    xmax = max(X(1, :)) + 1;
    xmin = min(X(1, :)) - 1;
    ymax = max(X(2, :)) + 1;
    ymin = min(X(2, :)) - 1;
    hold off;

    plot(X(1, y == 1), X(2, y == 1), 'bx', ...
    X(1, y == 0), X(2, y == 0), 'rx', ...
    X(1, y0 == 1), X(2, y0 == 1), 'bo', ...
    X(1, y0 == 0), X(2, y0 == 0), 'ro');
    axis([xmin xmax ymin ymax]);
    hold on;
%}
end
