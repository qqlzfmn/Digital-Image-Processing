function [] = yzfg()
I = imread('eight.tif');
BW = imbinarize(I);     % BW = im2bw(I,graythresh(I));
figure, imshowpair(I,BW,'montage')

% 以下为 R2016a 之前版本的程序
% I = imread('eight.tif');
% level = graythresh(I)     %采用 otsu(最大类间方差法) 算法
% BW = im2bw(I,level);
% imshow(BW)