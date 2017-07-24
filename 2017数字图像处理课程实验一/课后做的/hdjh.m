function [] = hdjh()
I = imread('cameraman.tif'); %读取图像
subplot(2,2,1),imshow(I) %输出图像
title('原始图像') %在原始图像中加标题
subplot(2,2,2),imhist(I) %输出原图直方图
title('原始图像直方图') %在原图直方图上加标题

%J = histeq(I,256); %直方图均衡化(课本P70)，灰度级为256，等价于以下代码段
%----------以下是计算灰度直方图(nk)的算法----------
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
%----------以下是计算分布密度(Pr(rk))的算法----------
P = zeros(1,256);
for k = 1 : 256
    P(k) = J(k) / (m * n * 1.0); %Pr(rk) = nk / n
end
%----------以下是计算累计直方图分布(sk计)的算法----------
S = zeros(1,256);
S(1) = P(1);
for k = 2 : 256
    S(k) = S(k-1) + P(k); %sk = Σ(j=0~k)nj / n   |   sk = Σ(j=0~k)Pr(rk)
end
%----------以下是计算累计分布取整(sk并)的算法----------
S = uint8(256 * S); %sk计 转换成 sk并，即在1~256范围内取整
%----------以下是对灰度值进行映射(根据灰度直方图还原图像)的算法----------
for i = 1 : m
    for j = 1 : n
        I(i,j) = S(I(i,j));
    end
end

subplot(2,2,3),imshow(I) %输出均衡化后图像
title('均衡化后图像') %在均衡化后图像中加标题
subplot(2,2,4),imhist(I) %输出均衡化后直方图
title('均衡化后直方图') %在均衡化后直方图上加标题
%figure,bar(S); %输出累计分布直方图
%title('累计分布直方图') %在累计分布直方图上加标题