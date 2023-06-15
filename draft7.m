clear all;
close all;

I=imread('.\fig\j0.jpg');%t  Ä¿±êÍ¼Ïñ
figure,imshow(I);
[m,n,q]=size(I);
I=double(I)./255;

A1=imread('.\fig\j5.jpg');%s  ²Î¿¼Í¼Ïñ
figure,imshow(A1);
A=imresize3(A1,[m,n,q]);
A=double(A)./255;


%²Î¿¼Í¼Ïñs
Aa = rgb2lab(A);
iis = Aa(:,:,1);
aas = Aa(:,:,2);
bbs = Aa(:,:,3);
iabs = cat(3,iis,aas,bbs);

uti=std2(iis);
uta=std2(aas);
utb=std2(bbs);
zti=mean(mean(iis));
zta=mean(mean(aas));
ztb=mean(mean(bbs));

%Ä¿±êÍ¼Ïñt
Ii = rgb2lab(I);
iit = Ii(:,:,1);
aat = Ii(:,:,2);
bbt = Ii(:,:,3);


zsi=mean(mean(iit));
zsa=mean(mean(aat));
zsb=mean(mean(bbt));
usi=std2(iit);
usa=std2(aat);
usb=std2(bbt);

II = (zsi/zti)*(iit-uti)+usi;
AA = (zsa/zta)*(aat-uta)+usa;
BB = (zsb/ztb)*(bbt-utb)+usb;

result = cat(3,II,AA,BB);
result = lab2rgb(result);
figure,imshow(result);





