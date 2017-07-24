function [] = zzlb()
I = imread('gaussian.tif');%读取图像
G = medfilt2(I,[3 3]);%中值滤波器
subplot(1,2,1),imshow(G) %输出图像
title('高斯噪声图像') %在高斯噪声图像中加标题
J = imread('salt & pepper.tif');%读取图像
H = medfilt2(J,[3 3]);%中值滤波器
subplot(1,2,2),imshow(H) %输出图像
title('椒盐躁声图像') %在椒盐躁声图像中加标题