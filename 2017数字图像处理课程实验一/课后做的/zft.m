function [] = zft()
I = imread('cameraman.tif'); %读取图像
subplot(1,2,1),imshow(I) %输出图像
title('原始图像') %在原始图像中加标题

%J = imhist(I); %计算直方图，算法公式：vi=ni/n(课本P25)，等价于以下代码段
[m,n] = size(I); %返回图像大小
J = zeros(1,256); %初始化直方图数组
for k = 0 : 255 %设置灰度级
    for i = 1 : m
        for j = 1 : n
            if I(i,j) == k
                J(k+1) = J(k+1) + 1; %灰度值相同的进行累加
            end
        end
    end
end

subplot(1,2,2),bar(J) %输出原图直方图
title('原始图像直方图') %在原图直方图上加标题