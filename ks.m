clear all;
close all;
G = imread('a.tif');
figure,subplot(1,2,1),imshow(G);
title("原始图像")
G=double(G)./255;
%% 图像预处理

G=medfilt2(G,[3,3]);
subplot(1,2,2),imshow(G);
title("中值滤波")
%% 图像增强(归一化)
[m n]=size(G);
M=0;VAR=0;
for x=1:m  
   for y=1:n     
         M=M+G(x,y);  
   end
end
M=M/(m*n); % 图像均值
for x=1:m   
  for y=1:n
        VAR=VAR+(G(x,y)-M).^2;
  end
end
VAR=VAR/(m*n); %图像方差
mean_s=0.3;
Mo=50;   %目标均值参数
Vo=1500; %目标方差参数
for i=1:m
    for j=1:n
        if((G(i,j)-mean_s)<0)
            MM(i,j)=Mo-(Vo*(M-G(x,y))/VAR)^0.5;
        else
            MM(i,j)=Mo+(Vo*(G(x,y)-M)/VAR)^0.5;
        end
    end
end
figure,imshow(uint8(MM));
title("归一化")

%% 图像细化
[a,b]=size(MM);
for i=2:a-1
    for j=2:b-1
        if MM(i,j)==0
            if (MM(i-1,j)==0&&MM(i,j+1)==0)||(MM(i-1,j)==0&&MM(i,j-1)==0)||(MM(i+1,j)==0&&MM(i,j-1)==0)||(MM(i+1,j)==0&&MM(i,j+1)==0)
                MM(i,j)=1;
            else
                MM(i,j)=0;
            end
        end
    end
end
figure,imshow(MM,[]);
title("细化图")

%% 图像特征提取
MM = abs(MM);
MM = mat2gray(MM);
t=0;
for i=2:a-1
    for j=2:b-1
        if MM(i,j)==0
            n=MM(i-1,j-1)+MM(i-1,j)+MM(i-1,j+1)+MM(i,j-1)+MM(i,j+1)+MM(i+1,j-1)+MM(i+1,j)+MM(i+1,j+1);
            if (n==7||n==5)
                t=t+1;
                x(t)=j;
                y(t)=i;
            end
        end
    end
end
figure;imshow(MM);
hold on;
plot(x,y,'bo');hold off; 
title("特征图")

%% 图像特征去伪
for i=1:t-1
    for j=i+1:t   
        d=((x(i)-x(j))^2+(y(i)-y(j))^2)^0.5;
        if d<3
            x(i)=-1;
            y(i)=-1;
            x(j)=-1;
            y(j)=-1;
        end
    end
end
figure;imshow(MM);
hold on;
plot(x,y,'bo');hold off; 
title("去伪特征图")