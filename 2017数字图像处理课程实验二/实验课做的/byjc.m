function [] = byjc()
i = imread('cameraman.tif');
j = edge(i,'sobel');
k = edge(i,'prewitt');
l = edge(i,'log');
subplot(2,2,1),imshow(i);
title('cameraman')
subplot(2,2,2),imshow(j);
title('sobel')
subplot(2,2,3),imshow(k);
title('prewitt')
subplot(2,2,4),imshow(l);
title('log')