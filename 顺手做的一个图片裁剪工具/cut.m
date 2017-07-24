function [] = cut()
clear;
srcDir=uigetdir('Choose source directory.'); %获得选择的文件夹
cd(srcDir);
allnames=struct2cell(dir('*.jpg')); %只处理8位的jpg文件
[k,len]=size(allnames); %获得jpg文件的个数
for ii=1:len
%逐次取出文件
name=allnames{1,ii};
I=imread(name); %读取文件
%----------图像处理程序----------
[x,y,z] = size(I);
n = 1;
a = 1;
b = y / 9 * 16;
while x > b
    J = I(a:b,1:y,1:z);
    a = b + 1;
    b = b + y / 9 * 16;
    imwrite(J,[name,num2str(n),'.jpg']);
    n = n + 1;
end
J = I(a:x,1:y,1:z);
imwrite(J,[name,num2str(n),'.jpg']);
%----------图像处理程序----------
end