%Preprocessing step
clear all, close all, clc;
addpath('training_data');

files = dir('training_data');
N = size(files, 1);
%n x m - new size of image
n = 40;
m = 40;
imgSize = n * m;
data = zeros(N - 2, imgSize);

for i = 3 : N
        I = load(files(i).name);
        pos = I.pos;

        X = pos(:, 1);                  %first dimension
        Y = pos(:, 2);                  %second dimension
        figure('visible', 'off');       %to see images, comment this line
        axis auto
        f1 = plot(X, Y);                %plotting the image using 2 dims
        set(gca, 'Visible', 'off');
        saveas(f1, 'img', 'png');       %making an image object
        %print('img2','-dpng', '-noui')
        img = imread('img.png');
        img = imresize(img,[n m]);      %resizing all images to one size 
        %img = rgb2gray(img);           %1)grayscale preprocessing
        img = im2bw(img, 0.99);         %2)binarization
        imshow(img);
        el = reshape(img, 1, []);       %transform array of pixels into line
        data(i - 2,:) = el;             %saving each image into data table
        disp(i);
end
%data = data / 255;                     %scaling for grayscale image
save('data.mat','data');

