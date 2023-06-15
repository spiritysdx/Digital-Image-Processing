clear all;
close all;
I = imread('.\zhiwen\101_1.tif');%103_4
subplot(6,2,1),imshow(I);
title("原始图像");
%I = rgb2gray(I);
%I = double(I)./255;
[m,n]=size(I);

%维纳滤波
%I1=wiener2(I,[3,3]);
%subplot(3,3,2),imshow(I1);
%title("维纳滤波");

%中值滤波
I1=medfilt2(I,[3,3]);
%subplot(3,3,2),imshow(I1);
%title("中值滤波");

%直方图均衡
[I1,T]=histeq(I1,256);
subplot(6,2,2),imshow(I1);
title("直方图均衡");

% garbo滤波


%二值化
%I1=imbinarize(I1);



%腐蚀
%s=ones(3,3);
%I2=imerode(I1,s);


% 图像锐化

%sobel算子
H=fspecial('sobel');
Ns=filter2(H,I1);
subplot(6,2,3),imshow(Ns);
title("未二值化进行sobel锐化")
Nsf=imcomplement(Ns);
subplot(6,2,4),imshow(Nsf);
title("反转sobel锐化")


%二值化
I2=imbinarize(I1);
Ns2=filter2(H,I1);
subplot(6,2,5),imshow(Ns2);
title("二值化进行sobel锐化")

Ns2f=imcomplement(Ns2);
subplot(6,2,6),imshow(Ns2f);
title("反转sobel锐化")

%拉普拉斯算子
h=[0 1 0,-4 1 0,0 1 0];
N1=convn(I1,h,'same');
subplot(6,2,7),imshow(N1);
title("未二值化进行拉普拉斯锐化")

N11=imcomplement(N1);
subplot(6,2,8),imshow(N11);
title("反转拉普拉斯锐化图")

N22=convn(I2,h,'same');
subplot(6,2,9),imshow(N22);
title("二值化进行拉普拉斯锐化")

N222=imcomplement(N22);
subplot(6,2,10),imshow(N222);
title("反转拉普拉斯锐化图")

% 细化
[a,b]=size(N11);
for i=2:a-1
    for j=2:b-1
        if N11(i,j)==0
            if (N11(i-1,j)==0&&N11(i,j+1)==0)||(N11(i-1,j)==0&&N11(i,j-1)==0)||(N11(i+1,j)==0&&N11(i,j-1)==0)||(N11(i+1,j)==0&&N11(i,j+1)==0)
                N11(i,j)=1;
            else
                N11(i,j)=0;
            end
        end
    end
end

subplot(6,2,11),imshow(N11);
title("细化图")

figure,imshow(N11);
title("细化图")

t=0;
for i=2:a-1
    for j=2:b-1
        if N11(i,j)==0
            n=N11(i-1,j-1)+N11(i-1,j)+N11(i-1,j+1)+N11(i,j-1)+N11(i,j+1)+N11(i+1,j-1)+N11(i+1,j)+N11(i+1,j+1);
            if (n==1||n==2)
                t=t+1;
                x(t)=j;
                y(t)=i;
            end
        end
    end
end

figure,hold on;
plot(x,y,'bo');hold off; 
title("特征图")


%figure,imshow(out);


% 展示图像

%subplot(3,3,2),imshow(I1);
%title("二值化");
%subplot(3,3,3),imshow(I2);



%figure,imshow(normim)




