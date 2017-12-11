function [C] = digit_classify(testdata)
%Digit_classify: gives answer about the truthless of the prediction
%
%   Example: digit_classify(testdata)
%
%   Input Arguments: 
%      Testdata - matrix with the test data
%
%   Output Arguments:
%      C - symbol which is drown on the picture

    %This code provides the representation of prediction digits for one image
    %using the weights for net which were evaluated
    %before (during the training process)

    n = 40; m = 40; 
    imgSize = n * m;

    %Parametres for building the neural network
    numHiddenNeurons = 16;
    a = 0.3;
    %Already evaluated weights
    weightsData = matfile('w01.mat'); w01 = weightsData.w01;
    weightsData = matfile('w12.mat'); w12 = weightsData.w12;

    %image preprocessing step
    X = testdata(:, 1);
    Y = testdata(:, 2);
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

    y0 = test_net(el, numHiddenNeurons, w01, w12, a);
    newY0 = output_transformation(y0);
    ind = find(newY0 == 1);
    C = ind - 1; %because numeration of digits from zero 
end

