%º”∑®»•‘Î

close all;
clear all;
strim = '.\fig\Fig0226.tif';
g = double(imread(strim))./255;
[m,n]=size(g);
gn=zeros(m,n,100);
for i=1:100
    tt=imnoise(g,'gaussian',0,64^2/255^2);
    gn(:,:,i)=tt;
end
gns5=mean(gn(:,:,1:5),3);
gns10=mean(gn(:,:,1:10),3);
gns20=mean(gn(:,:,1:20),3);
gns50=mean(gn(:,:,1:50),3);
gns100=mean(gn,3);
figure,subplot(2,3,1),imshow(gn(:,:,1));
subplot(2,3,2),imshow(gns5);
subplot(2,3,3),imshow(gns10);
subplot(2,3,4),imshow(gns20);
subplot(2,3,5),imshow(gns50);
subplot(2,3,6),imshow(gns100);


