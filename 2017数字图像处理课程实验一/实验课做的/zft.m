function [] = zft()
I=imread('cameraman.tif');%读取图像
subplot(1,2,1),imshow(I) %输出图像
title('原始图像') %在原始图像中加标题
subplot(1,2,2),imhist(I) %输出原图直方图
title('原始图像直方图') %在原图直方图上加标题