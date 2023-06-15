
close all;
clear all;
i=imread('.\fig\Fig0340a.tif');
I=mat2gray(i);
figure,imshow(I);

H=fspecial('gaussian',[5 5],3);
J=imfilter(I,H);
figure,imshow(J);
imwrite(J,'Fig0340b.tif');


K=I-J;
K1=mat2gray(K);
figure,imshow(K1);
imwrite(K1,'Fig0340c.tif');

I2=I+K;
figure,imshow(I2);
imwrite(I2,'Fig0340d.tif');


I3=I+4.5*K;
figure,imshow(I3);
imwrite(I3,'Fig0340e.tif')








