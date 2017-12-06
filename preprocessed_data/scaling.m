clear all;
inputData = matfile('data_40x40_gray.mat');
data = inputData.data;

data = data / 255;
ind = find(data ~= 1);
data(ind)= data(ind) - 0.5; 
save('data_40x40_gray_scaled.mat','data');