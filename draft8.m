close all,clear all;
A=imread('.\fig\j0.jpg');
figure,imshow(A);
A1=imnoise(A,'gaussian',0,0.01);%��Ӹ�˹����
figure,imshow(A1);
w=21;
H=fspecial('gaussian',[w,w]);%��˹�˲���
H1=imfilter(A1,H);
figure,imshow(H1);
I=rgb2gray(A1);
I2=medfilt2(I,[w,w]);%21*21
figure,imshow(I2);
B=rgb2lab(A1);%IAB
%figure,imshow(B);



% ���ò���
r = 3;% �˲��뾶
a = 3;% ȫ�ַ���
b = 6;% �ֲ�����
g1 = bfilt_rgb(B,r,a,b);
g2 = bfilt_rgb(g1,r,a,b);
g3 = bfilt_rgb(g2,r,a,b);

C = lab2rgb(g3);
figure,imshow(C);





