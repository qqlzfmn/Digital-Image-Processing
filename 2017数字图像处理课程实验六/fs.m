function [] = fs()
I=imread('finger.tif');
subplot(1,2,1),imshow(I);
title('原图');
BW=I;
BW=rgb2gray(BW);
SE=strel('square',2); %结构元素为边长2像素的正方形
BW=imopen(BW,SE); %开运算（先腐蚀再膨胀）可以消除小物体、在纤细点处分离物体、平滑较大物体的边界。
%BW=imerode(BW,SE); %腐蚀
%BW=medfilt2(BW,[3 3]); %中值滤波(腐蚀后中值滤波可能导致本来连接的指纹断开)
%BW=imdilate(BW,SE); %膨胀

%BW=imclose(BW,SE); %闭运算（先膨胀再腐蚀）能够排除小型黑洞(黑色区域)。
BW=imdilate(BW,SE); %膨胀
BW=medfilt2(BW,[3 3]); %中值滤波（膨胀后中值滤波可能导致指纹图像噪声去除不干净）
BW=imerode(BW,SE); %腐蚀
subplot(1,2,2),imshow(BW);
title('处理后');
%BW=bwmorph(BW,'thin',Inf); %骨架化
%figure,imshow(BW);
%title('骨架化');