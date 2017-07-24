function [] = txxz(angle)
A = imread('cameraman.tif');
B = imrotate(A,angle);
figure,imshow(B);