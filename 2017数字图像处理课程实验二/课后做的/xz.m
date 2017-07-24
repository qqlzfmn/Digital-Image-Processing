function [] = xz(angle)
%angle为逆时针旋转角度
I = imread('cameraman.tif'); %读取图像
% subplot(1,2,1),imshow(I); %输出图像
% title('原始图像'); %在原始图像中加标题
J = imrotate(I,angle);
figure,imshow(J);
title({['逆时针旋转',num2str(angle),'°后的图像']}); %在缩放后的图像上加标题

%不想重新写了，程序员应该尽量避免重复发明轮子(Don't reinvent the wheel)，
%在旋转后出现出现背景色的规则花纹是因为坐标的映射无法使坐标连续，
%用3*3不带中心点的八个像素点均值滤波图像部分即可解决。