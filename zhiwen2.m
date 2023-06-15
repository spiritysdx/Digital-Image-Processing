clear all;
close all;
I = imread('.\zhiwen\103_4.tif');
figure,imshow(I);
title("原始图像")
I1=medfilt2(I,[3,3]);
[I1,T]=histeq(I1,256);
h=[0 1 0,-4 1 0,0 1 0];
N1=convn(I1,h,'same');
N11=imcomplement(N1);

% 增强
temp = N1-double(I1);
tp1=fft2(I1);
tp2=fft2(temp);
out=dftregistration(tp1,tp2,1);%配准
[width,height]=size(temp);
Newtemp=zeros(width,height);
for i=1:width
    for j=1:height
        source_x=i+1;
        source_y=j+1;
        if(source_x>width||source_y>height)
            Newtemp(i,j)=0;
        else if(((source_x/double(uint16(source_x)))==1.0)&&((source_y/double(uint16(source_y))==1.0)))
                Newtemp(i,j)=temp(int16(source_x),int16(source_y));
            end
        end
    end
end
tp3=imadd(uint8(I1),uint8(Newtemp),'uint16');
figure,imshow(tp3,[]);


% 细化
tp3=medfilt2(tp3,[3,3]);
h=[0 1 0,-4 1 0,0 1 0];
tp3=convn(tp3,h,'same');
tp3=imcomplement(tp3);
[a,b]=size(tp3);
for i=2:a-1
    for j=2:b-1
        if tp3(i,j)==0
            if (tp3(i-1,j)==0&&tp3(i,j+1)==0)||(tp3(i-1,j)==0&&tp3(i,j-1)==0)||(tp3(i+1,j)==0&&tp3(i,j-1)==0)||(tp3(i+1,j)==0&&tp3(i,j+1)==0)
                tp3(i,j)=1;
            else
                tp3(i,j)=0;
            end
        end
    end
end
figure,imshow(tp3,[]);