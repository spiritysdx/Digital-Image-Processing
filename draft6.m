clear all;
close all;

K=0.7;
I=imread('.\fig\ye04.png');
figure,imshow(I);
I=rgb2gray(I);
I=double(I);
[n,m]=size(I);
J=zeros(n,m);
for i=1:n
    for j=1:m
        J(i,j)=Gray_map(I(i,j),K);
    end
end
figure,imshow(uint8(J));
imwrite(J,'yf.bmp');