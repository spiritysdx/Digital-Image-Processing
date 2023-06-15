function res = bfilt_gray(img,r,a,b)
% f灰度图;r滤波半径 ;a全局方差;b局部方差
[x,y] = meshgrid(-r:r);
w_spatial = exp(-( x.^2+y.^2 )/(2*a^2));  
img = im2double(img); 
 
[m,n] = size(img);
f_temp = padarray(img,[r r],'symmetric');  % 边缘填充
res = zeros(m,n);
for i = r+1:m+r
    for j = r+1:n+r
        count = count +1;
        temp = f_temp(i-r:i+r,j-r:j+r); % 一个局部块的像素值
        w_pixel = exp(  -( temp- img(i-r,j-r) ).^2/(2*b^2)); 
        w = w_spatial .* w_pixel;
        s = temp.*w;
        res(i-r,j-r) = sum(s(:)) / sum(w(:)); % 计算该点新的像素值
    end
end
end