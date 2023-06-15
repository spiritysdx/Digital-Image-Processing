close all,clear all;
A=imread('.\fig\j0.jpg');
figure,imshow(A);
A1=imnoise(A,'gaussian',0,0.01);%��Ӹ�˹����
figure,imshow(A1);
sigma=3;
w=21;
H=fspecial('gaussian',[w,w],sigma);%��˹�˲���
H1=imfilter(A1,H,'replicate');
%figure,imshow(H1);
I=rgb2gray(A1);
I2=medfilt2(I,'symmetric');
I3=medfilt2(I,[w,w],'symmetric');%21*21
%figure,imshow(I2);
%figure,imshow(I3);
B=rgb2lab(A1);%IAB

%˫���˲�
img=rgb2gray(A1);
[m,n]=size(img);
r=10;        %ģ��뾶
imgn=zeros(m+2*r+1,n+2*r+1);
imgn(r+1:m+r,r+1:n+r)=img;
imgn(1:r,r+1:n+r)=img(1:r,1:n);                 %��չ�ϱ߽�
imgn(1:m+r,n+r+1:n+2*r+1)=imgn(1:m+r,n:n+r);    %��չ�ұ߽�
imgn(m+r+1:m+2*r+1,r+1:n+2*r+1)=imgn(m:m+r,r+1:n+2*r+1);    %��չ�±߽�
imgn(1:m+2*r+1,1:r)=imgn(1:m+2*r+1,r+1:2*r);       %��չ��߽�

sigma_d=2;
sigma_r=0.1;
[x,y] = meshgrid(-r:r,-r:r);
w1=exp(-(x.^2+y.^2)/(2*sigma_d^2));     %�Ծ�����Ϊ�Ա�����˹�˲���

t=waitbar(0,'wait...');
for i=r+1:m+r
    for j=r+1:n+r        
        w2=exp(-(imgn(i-r:i+r,j-r:j+r)-imgn(i,j)).^2/(2*sigma_r^2)); %����Χ�͵�ǰ���ػҶȲ�ֵ��Ϊ�Ա����ĸ�˹�˲���
        w=w1.*w2;
        
        s=imgn(i-r:i+r,j-r:j+r).*w;
        imgn(i,j)=sum(sum(s))/sum(sum(w));
    
    end
    waitbar(i/m);
end
close(t)
figure;
subplot(3, 4, 6);
imshow(mat2gray(imgn(r+1:m+r,r+1:n+r)));
title('˫���˲�');