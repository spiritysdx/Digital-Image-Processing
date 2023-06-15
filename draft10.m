clear all;
close all;

I=imread('.\fig\j0.jpg');%t  Ä¿±êÍ¼Ïñ
figure,imshow(I);
[m,n,q]=size(I);

A=imread('.\fig\j5.jpg');%s  ²Î¿¼Í¼Ïñ
figure,imshow(A);
A=imresize3(A,[m,n,q]);

I1=double(I)/255;
I2=double(A)/255;
lab1=rgb2lab(I1);
lab2=rgb2lab(I2);
gI1=lab1(:,:,1);
gI2=lab2(:,:,1);
[ms,ns]=size(gI1);
[mt,nt]=size(gI2);
mean_s=mean2(gI1);
mean_t=mean2(gI2);
c_s=std2(gI1);
c_t=std2(gI2);
gI2=(gI2-mean_t)*c_s/c_t+mean_s;
wd=3;
rx=randi([wd+1,ms-wd],[20,1]);
ry=randi([wd+1,ms-wd],[20,1]);
for j=1:20
    for i=1:20
        wg=gI1(rx(i)-wd:rx(i)+wd,ry(j)-wd:ry(j)+wd);
        mean_varl(i,j)=mean2(wg);
        c_var1(i,j)=max(std2(wg),0.0002);
    end
end
lab2(:,:,1)=gI2;
gp2=padarray(gI2,[wd,wd]);
for j=1:nt
    for i=1:mt
        ii=i+wd;
        jj=j+wd;
        wg=gp2(ii-wd:ii+wd,jj-wd:jj+wd);
        mean_var2(i,j)=mean2(wg);
        c_var2(i,j)=max(std2(wg),0.0002);
        for rj=1:20
            for ri=1:20
                wwm(ri,rj)=abs((mean_var2(i,j)-mean_varl(ri,rj)))/(mean_var2(i,j)+mean_varl(ri,rj));
                wwv(ri,rj)=abs((c_var2(i,j)-c_var1(ri,rj)))/(c_var2(i,j)+c_var1(ri,rj));
                wwsum(ri,rj)=0.5*wwm(ri,rj)+0.5*wwv(ri,rj);
            end
        end
        [temp,row]=min(wwsum);
        [wdiff(i,j),col]=min(temp);
        min_ri=row(col);
        min_rj=col;
        lab2(i,j,2)=lab1(rx(min_ri),ry(min_rj),2);
        lab2(i,j,3)=lab1(rx(min_ri),ry(min_rj),3);
    end
end
cform=makecform('lab2srgb');
It_c=lab2rgb(lab2);
It_c=mat2gray(It_c);
figure,subplot(1,3,1),imshow(I1);subplot(1,3,2),imshow(I2);subplot(1,3,3),imshow(It_c);
