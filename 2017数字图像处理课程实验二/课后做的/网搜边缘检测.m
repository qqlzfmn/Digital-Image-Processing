function [] = by()
%边缘检测网上找到的代码，生成的是带边缘检测的灰度图，不是提取边缘的二值图像
im = imread('cameraman.tif');  %读取关键帧
subplot(131);imshow(im);title('原图');
[high,width] = size(im);   % 获得图像的高度和宽度
U = double(im);         
uSobel = im;
for i = 2:high - 1   %sobel边缘检测
    for j = 2:width - 1
        Gx = (U(i+1,j-1) + 2*U(i+1,j) + U(i+1,j+1)) - (U(i-1,j-1) + 2*U(i-1,j) + U(i-1,j+1));
        Gy = (U(i-1,j+1) + 2*U(i,j+1) + U(i+1,j+1)) - (U(i-1,j-1) + 2*U(i,j-1) + U(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end 
subplot(132);imshow(im2uint8(uSobel));title('边缘检测后');  %画出边缘检测后的图像
% Matlab自带函数边缘检测
% K为获取得到的关键帧的灰度图
BW3 = edge(im,'sobel');
subplot(133);imshow(BW3,[]);title('Matlab自带函数边缘检测');