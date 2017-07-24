function [] = ft()
I = imread('at3_1m4_04.tif');
subplot(2,3,1),imshow(I) %读文件并显示
title('原始图像')
J = fft2(double(I)); %傅里叶变换
subplot(2,3,2),imshow(imag(J))
title('傅里叶变换')
K = imag(fftshift(J));
subplot(2,3,3),imshow(K) %频移并显示
title('频移并显示')
L = ifft2(J)/256; %直接傅立叶反变换
subplot(2,3,4),imshow(L)
title('直接傅立叶反变换')
M = ifft2(sqrt(real(J).^2+imag(J).^2))/256; %幅度傅立叶反变换
subplot(2,3,5),imshow(M)
title('幅度傅立叶反变换')
N = abs(ifft2(ifftshift(angle(K))));%相位傅立叶反变换
N = (N-min(min(N)))/(max(max(N))-min(min(N)))*256; %归一化
subplot(2,3,6),imshow(N)
title('相位傅立叶反变换')