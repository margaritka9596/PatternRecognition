clear all, close all, clc;
inputData = matfile('data.mat');
data = inputData.data;
samples = size(data, 1);
labels = zeros(samples, 1);
output = zeros(samples, 10);

%creating a labels array based on the number of sample (there are 1000 samples, 100 per digit)
divider = int32(100);
for i = 1 : samples
    labels(i) = idivide(i - 1, divider, 'floor');
    output(i, labels(i) + 1) = 1; % +1 for the reason of numeration from 1
end

%Dividing 1000 samples into train and test data
train_size = 0.7;   %test_size =  1 - 0.7 = 0.3
[train_data, train_class, test_data, test_class] = divide_data(data, output, train_size);

%Parametres for net 
l_rate = 0.1;   %learning coefficient
n_epoch = 200;
%only one hiden layer exist
n_hidden = 16;  %num of neurons in hidden layer
a = 0.3;        %coeff for sigma function

%start notifying the time
tic;

%Training net on train data
%[w01, w12] = train_net(train_data, train_class, l_rate, a, n_hidden, n_epoch);

toc;

%Testing the net
%Getting previous generated weights for net
weightsData = matfile('w01_90%_test.mat'); w01 = weightsData.w01;
weightsData = matfile('w12_90%_test.mat'); w12 = weightsData.w12;

%Testing net on the same data, as we used to train net
disp('Results for train data:');
y0_1 = test_net(train_data, n_hidden, w01, w12, a);
newY0_1 = output_transformation(y0_1);

num_true_predicted(newY0_1, train_class);
disp('__________________________________________________________________________');
disp('Results for test data:');
y0_2 = test_net(test_data, n_hidden, w01, w12, a);
newY0_2 = output_transformation(y0_2);

num_true_predicted(newY0_2, test_class);


