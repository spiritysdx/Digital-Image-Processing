function res = bfilt_rgb(img,r,a,b)
% f灰度图；r滤波半径；a全局方差；b局部方差

res = zeros(size(img)) ;
for ch = 1:3
     res(:,:,ch) = bfilt_gray(img(:,:,ch),r,a,b);
end

end