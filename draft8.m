close all,clear all;
A=imread('.\fig\j0.jpg');
figure,imshow(A);
A1=imnoise(A,'gaussian',0,0.01);%添加高斯噪声
figure,imshow(A1);
w=21;
H=fspecial('gaussian',[w,w]);%高斯滤波器
H1=imfilter(A1,H);
figure,imshow(H1);
I=rgb2gray(A1);
I2=medfilt2(I,[w,w]);%21*21
figure,imshow(I2);
B=rgb2lab(A1);%IAB
%figure,imshow(B);



% 设置参数
r = 3;% 滤波半径
a = 3;% 全局方差
b = 6;% 局部方差
g1 = bfilt_rgb(B,r,a,b);
g2 = bfilt_rgb(g1,r,a,b);
g3 = bfilt_rgb(g2,r,a,b);

C = lab2rgb(g3);
figure,imshow(C);





