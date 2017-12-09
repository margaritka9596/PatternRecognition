%This code provides the representation of prediction digits for each image
%in the particular folder using the weights for net which were evaluated
%before during the training process
clear all, close all, clc;
addpath('training_data');
addpath('test_image');

files = dir('training_data');
%files = dir('test_image');
N = size(files, 1);
n = 40; m = 40; 
imgSize = n * m;

data = zeros(N - 2, imgSize); % -2 because there are some other(hidden) files in each folder which are not an images
%Parametres for building the neural network
numHiddenNeurons = 16;
a = 0.3;
%Areadyevaluated weights
weightsData = matfile('w01.mat'); w01 = weightsData.w01;
weightsData = matfile('w12.mat'); w12 = weightsData.w12;

for i = 3 : N
        %image preprocessing step
        I = load(files(i).name);
        pos = I.pos;

        X = pos(:, 1);
        Y = pos(:, 2);
        %figure('visible', 'off');
        axis auto

        f1 = plot(X, Y);
        set(gca, 'Visible', 'off');
        saveas(f1, 'img', 'png') 
        img = imread('img.png');
        img = imresize(img,[n m]);
        img = im2bw(img, 0.99);
        %imshow(img);
        el = reshape(img, 1, []);
        
        fprintf('Iter_num = %d\n', i - 2);
        y0 = test_net(el, numHiddenNeurons, w01, w12, a);
        newY0 = output_transformation(y0);
        ind = find(newY0 == 1);
        fprintf('It is %d\n', ind - 1);
        disp('');     
end


