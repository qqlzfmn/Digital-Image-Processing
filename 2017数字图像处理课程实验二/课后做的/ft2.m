function [] = ft2()
I = imread('mri.tif'); %读入原图像文件
subplot(1,2,1),imshow(I) %显示原图像
title('原图像')
J=fft2(double(I)); %二维离散傅立叶变换
K = fftshift(J); %直流分量移到频谱中心
R = real(K); %取傅立叶变换的实部
I = imag(K); %取傅立叶变换的虚部
L = sqrt(R.^2+I.^2); %计算频谱幅值
L = (L-min(min(L)))/(max(max(L))-min(min(L)))*256; %归一化
subplot(1,2,2) %设定窗口
imshow(L) %显示原图像的频谱
title('原图像的频谱')