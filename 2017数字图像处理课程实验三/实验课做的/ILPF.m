function []=ILPF(inputimage,D0)
%D0 为输入截止频率，inputimage 为输入图像
I=imread(inputimage);%读入图像
h=figure;
set(h,'name','理想低通滤波图','Numbertitle','off')
subplot(1,3,1),imshow(I);
title('原图');
I=imnoise(I,'salt & pepper',0.02); %加入椒盐躁声
subplot(1,3,2),imshow(I);
title('加入椒盐躁声图');
f=double(I); % 由于MATLAB 不支持unsigned int 型图像计算，故将图像数据变为double 型
g=fft2(f); % 傅里叶变换
g=fftshift(g); % 将傅里叶变化零频率搬移到频谱中间
[M,N]=size(g); % 确定图像大小,M 为行数，N 为列数
m=fix(M/2); n=fix(N/2);% 确定傅里叶变化原点（即直流部分），并且数据向0 取整
result=zeros(M,N);
for i=1:1:M
for j=1:1:N
d=sqrt((i-m)^2+(j-n)^2);%计算D(u，v)
if(d<=D0)
h=1;%如果D(u，v)<=D0, H(u,v)=1
else
h=0;%如果D(u，v)>D0, H(u,v)=0
end
result(i,j)=h*g(i,j);
end
end
result=ifftshift(result);% 傅里叶逆移频，由于之前做过fftshift
J1=ifft2(result);% 傅里叶反变换
J2=uint8(real(J1));%提取J1 的实部,并将该数据定义为8 位无符号整数
subplot(1,3,3),imshow(J2) ;
title('理想低通滤波图');