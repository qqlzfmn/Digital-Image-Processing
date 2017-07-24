function [] = ft()
I = imread('at3_1m4_04.tif');
figure,imshow(I) %读文件并显示
J = fft2(double(I)); %傅里叶变换
figure,imshow(J)
K = fftshift(J);
figure,imshow(K) %频移并显示
L = ifft2(J)/256; %直接傅立叶反变换
figure,imshow(L)
M = ifft2(2*sqrt(J.*conj(J)))/256; %幅度傅立叶反变换
figure,imshow(M)
N = ifft2(abs(angle(J))*256); %相位傅立叶反变换
figure,imshow(N)