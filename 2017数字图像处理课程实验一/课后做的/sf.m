function [] = sf(x)
I = imread('cameraman.tif');%读取图像
[m,n] = size(I);
figure,imshow(I); %输出图像
title({['原始图像：长',num2str(m),'像素，宽',num2str(n),'像素']}); %在原始图像中加标题
J = imresize(I,x); %图像缩放x倍
[m,n] = size(J);
figure,imshow(J); %输出缩放后的图像
title({['缩放',num2str(x),'倍后的图像：长',num2str(m),'像素，宽',num2str(n),'像素']}); %在缩放后的图像上加标题

%不想重新写了，程序员应该尽量避免重复发明轮子(Don't reinvent the wheel)，能看懂插值算法就好了