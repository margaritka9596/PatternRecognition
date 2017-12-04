clear all, close all, clc;
addpath('training_data');

files = dir('training_data');
N = size(files, 1);
n = 40;
m = n;
imgSize = n * m;
data = zeros(N - 2, imgSize);

for i = 3 : N
        %image preprocessing step
        I = load(files(i).name);
        pos = I.pos;

        X = pos(:, 1);
        Y = pos(:, 2);
        figure('visible', 'off');
        %минимальный описывающий квадрат нужен, это говнище
        axis auto

        f1 = plot(X, Y);
        set(gca, 'Visible', 'off');
        saveas(f1, 'img', 'png')
        %print('img2','-dpng', '-noui')
        img = rgb2gray(imread('img.png'));
        img = imresize(img,[n m]);
        %imshow(img);
        el = reshape(img, 1, []);
        data(i - 2,:) = el;
        disp(i);
end

save('data.mat','data');

