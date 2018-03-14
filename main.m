clear all, close all, clc;
addpath('training_data');
addpath('test_image');

%files = dir('training_data');
files = dir('test_image');

I = load(files(3).name);    %3 because there are always 2 system files in e ach folder
pos = I.pos;


C = digit_classify(pos);
fprintf('It is %d\n', C);