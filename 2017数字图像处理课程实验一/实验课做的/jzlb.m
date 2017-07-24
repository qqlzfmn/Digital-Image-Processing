function [] = jzlb()
I=imread('gaussian.tif');%读取图像
G=fspecial('average',[3 3]);%均值滤波器
Average1=imfilter(I,G,'replicate');
subplot(1,2,1),imshow(Average1) %输出图像
title('高斯噪声图像') %在高斯噪声图像中加标题
J=imread('salt & pepper.tif');%读取图像
H=fspecial('average',[3 3]);%均值滤波器
Average2=imfilter(J,H,'replicate');
subplot(1,2,2),imshow(Average2) %输出图像
title('椒盐躁声图像') %在椒盐躁声图像中加标题