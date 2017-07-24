function [] = fttt()
f = zeros(64,64);
for j=1:5
   f(:,j*10:j*10+1)=1;
end
F=fft2(f);Fc=fftshift(F);
F1=ifft(angle(F));Fc1=ifftshift(F1);
F2=fft2(F);Fc2=fftshift(F2);
figure,
subplot(2,2,1),imshow(f,[ ]);title('原始图像');
subplot(2,2,2),imshow(abs(Fc),[ ]);title('图像傅里叶变换');
subplot(2,2,3),imshow(abs(Fc1),[ ]);title('傅里叶相位谱进行傅里叶反变换');
subplot(2,2,4),imshow(abs(Fc2),[]);title('傅里叶变换再进行傅里叶变换');