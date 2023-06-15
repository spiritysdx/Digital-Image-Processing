%灰度分辨率变化
clear all;
strnm0 = '.\fig\a4.bmp';
f = imread(strnm0);
g = rgb2gray(f);%灰度图

for j=7:-1:1
    gj0=bitshift(g,-(8-j));
    gj=double(gj0)/(2^j-1);
    str=num2str(j,'_g%d.bmp');
    strnm=['.\a4',str];
    figure,
    imshow(gj)
    imwrite(gj,strnm)
end
