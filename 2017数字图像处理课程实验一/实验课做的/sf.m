function [] = sf(x)
I=imread('cameraman.tif');%读取图像
figure,imshow(I); %输出图像
title('原始图像'); %在原始图像中加标题
J=imresize(I,x); %图像缩放x倍
figure,imshow(J); %输出缩放后的图像
title('缩放后的图像'); %在缩放后的图像上加标题