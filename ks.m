clear all;
close all;
G = imread('a.tif');
figure,subplot(1,2,1),imshow(G);
title("ԭʼͼ��")
G=double(G)./255;
%% ͼ��Ԥ����

G=medfilt2(G,[3,3]);
subplot(1,2,2),imshow(G);
title("��ֵ�˲�")
%% ͼ����ǿ(��һ��)
[m n]=size(G);
M=0;VAR=0;
for x=1:m  
   for y=1:n     
         M=M+G(x,y);  
   end
end
M=M/(m*n); % ͼ���ֵ
for x=1:m   
  for y=1:n
        VAR=VAR+(G(x,y)-M).^2;
  end
end
VAR=VAR/(m*n); %ͼ�񷽲�
mean_s=0.3;
Mo=50;   %Ŀ���ֵ����
Vo=1500; %Ŀ�귽�����
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
title("��һ��")

%% ͼ��ϸ��
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
title("ϸ��ͼ")

%% ͼ��������ȡ
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
title("����ͼ")

%% ͼ������ȥα
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
title("ȥα����ͼ")