%Í¼ÏñÐý×ª
clear all;
close all;

I=imread('.\fig\a5.bmp');
I1=imrotate(I,-10,'crop');
I2=imrotate(I,-10,'bilinear','crop');
I3=imrotate(I,-10,'bilinear');

figure;imshow(I);
figure;imshow(I1);
figure;imshow(I2);
figure;imshow(I3);



