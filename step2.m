clear all, close all, clc;
%TODO
%1)find out why there is shift in 35 values in the output
%2)check if it's ok that there is a shift,maybe it doesn't work at all
%3)divide data into test and train data
%4)change sigma maybe
%5)create 3 stop rules: num_iter, min difference of error, min_difference
%between epochs
%6)create a plotof learning
%c 100x100 image, 0.9 learning and 400 epochs =  74%true   |on the same traindata as the
%testdata
%7)make testing for real test data
%8)implement the possibility to change num of neurons per layer

inputData = matfile('data.mat');
data = inputData.data;
samples = size(data, 1);
labels = zeros(samples, 1);
output = zeros(samples, 10);

divider = int32(100);
for i = 1 : samples
    labels(i) = idivide(i - 1, divider, 'floor');
    output(i, labels(i) + 1) = 1; % +1 for the reason of numeration from 1
end

[train_data, train_class, test_data, test_class] = divide_data(data, output);
n_folds = 5;
% Learning coefficient
l_rate = 0.9;%0 .3
n_epoch = 400;
n_hidden = 3;

%start notifying the time
tic;

%flag = 0; %0 = train net| 1 = test net
neuron_net(data, output, l_rate, n_hidden, n_epoch);


resData = matfile('y0.mat');
res = resData.y0;
newY0 = output_transformation(res);
num_true_predicted(output, newY0);
%}

%num_true_predicted(output, newY0);

toc;


