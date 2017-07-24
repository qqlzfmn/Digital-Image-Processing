function [] = zzlb()
lb('gaussian.tif')
title('高斯噪声经3×3中值滤波后的图像') %在高斯噪声图像中加标题
lb('salt & pepper.tif')
title('椒盐躁声经3×3中值滤波后的图像') %在椒盐躁声图像中加标题
function [] = lb(x)
I = imread(x);%读取图像
if size(I,3)>1 %判断如果是彩色图像
    I = rgb2gray(I);%将图像转为二维灰度图像
end
[m,n] = size(I);
    for x = 2 : (m-1)
        for y = 2 : (n-1)
            G(x,y) = median([I(x-1,y-1) I(x,y-1) I(x+1,y-1) I(x-1,y) I(x,y) I(x+1,y) I(x-1,y+1) I(x,y+1) I(x+1,y+1)]);
        end
    end
figure,imshow(G) %输出图像

% 网上找到的程序代码(可复用性强)
% f = imread('F:\matlab_ex\imageProcessing\wx.jpg');  
% [height, width] = size(f);  
% x1 = double(f);  
% x2 = x1;  
% for i = 1:height-n+1  
%     for j = 1:width-n+1  
%         c = x1(i:i+n-1,j:j+n-1);  
%         e = c(1,:);  
%         for k = 2:n  
%             e = [e, c(k, :)];  
%         end  
%         tmp = median(e);  
%         x2(i+(n-1)/2,j+(n-1)/2) = tmp;  
%     end  
% end  
%   
% g = uint8(x2);  
% imshow(g);  