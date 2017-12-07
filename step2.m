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
%сравнивать ттак результаты некорректно, так как в первом случае считаетс€
%выход по измен€ющимс€ и тренирующимс€ весам, а во втором уже готовые веса
%и мы прогон€ем 1000 семплов
%теперь второй вопрос, почему всегда предсказывает одну цифру, это же говно
%и надо узнать почему 1) либо сама проверка говно 2) плохо натренированные
%веса
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
l_rate = 0.1;%0.3
n_epoch = 200;
n_hidden = 16;
a = 0.3;
%32%_0.3_120_16_0.3
%49%_0.2_300_16_0.3
%start notifying the time
tic;

%flag = 0; %0 = train net| 1 = test net
%neuron_net(data, output, l_rate, n_hidden, n_epoch);
neuron_net(train_data, train_class, l_rate, a, n_hidden, n_epoch);

resData1 = matfile('y0.mat');
res1 = resData1.y0;
newY0_1 = output_transformation(res1);

newOutputData = matfile('y.mat');
newOutput = newOutputData.y;

num_true_predicted(newOutput, newY0_1);
%}

disp('__________________________________________________________________________');
weightsData = matfile('w01.mat');
w01 = weightsData.w01;
weightsData = matfile('w12.mat');
w12 = weightsData.w12;


test_net(test_data, n_hidden, w01, w12, a);

resData2 = matfile('y0_test.mat');
res2 = resData2.y0;
newY0_2 = output_transformation(res2);

num_true_predicted(newY0_2, test_class);

toc;


%потом о€зательно переписать через л€мбду
%{
Nd = size(data, 2);

val = {};
for i = 1 : Nd
    val = val + {data(i,:)};
end

val = arrayfun(@(x) ({x}), data);
disp(val);
mapObj = containers.Map(labels, val)
%}
%mapObj = containers.Map(labels, arrayfun(@(x) ({x}), data))
%bn = size(data, 2);
%mapObj = containers.Map(labels, cellfun(@(x) x(1:bn), data,'UniformOutput', false));


