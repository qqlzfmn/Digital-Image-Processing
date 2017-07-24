function [] = op()
I=imread('rectangel.tif');
subplot(1,2,1),imshow(I);
title('原图');
BW=I;
BW=rgb2gray(BW);
SE=strel('square',10);%结构元素为边长10像素的正方形
BW=imopen(BW,SE); %开运算
BW=imclose(BW,SE); %闭运算
subplot(1,2,2),imshow(BW);
title('处理后');