function [] = hdjh()
I=imread('cameraman.tif');%读取图像
subplot(2,2,1),imshow(I) %输出图像
title('原始图像') %在原始图像中加标题
subplot(2,2,2),imhist(I) %输出原图直方图
title('原始图像直方图') %在原图直方图上加标题
J=histeq(I,256);%直方图均衡化，灰度级为256
subplot(2,2,3),imshow(J)%输出均衡化后图像
title('均衡化后图像')%在均衡化后图像中加标题
subplot(2,2,4),imhist(J) %输出均衡化后直方图
title('均衡化后直方图') %在均衡化后直方图上加标题