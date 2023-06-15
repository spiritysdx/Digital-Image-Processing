function b = BF_Filter(img,r,sigma_d,sigma_r)
%% 功能说明：双边滤波，用于计算双边滤波后的图像
%          双边滤波是一种非线性方法，同时考虑图像的空域信息和灰度相似性。
%          通过空域矩阵和值域矩阵形成新的权重矩阵，其中，空域矩阵用来模糊去噪，值域矩阵用来保护边缘。
%% 输入参数：img -- 待滤波图像
%          r -- 模板半径，e.g. 3*3模版的半径为1
%          sigma_d -- 空域矩阵标准差
%          sigma_r -- 值域矩阵标准差
    
    % 判断是否为灰度图像
    if(size(img,3)>1)
        img = rgb2gray(img);
    end
    [x,y] = meshgrid(-r:r);
    
    % 空域权重矩阵 size = (2r+1)*(2r+1)
    w_spacial = exp(-(x.^2 + y.^2)/(2*sigma_d.^2));
 
    [m,n] = size(img);
    img = double(img);
    
    % 扩展图像，size = (m+2r)*(n+2r)
    f_temp = padarray(img,[r r],'symmetric');
    
    % 滑动窗口并滤波
    b = zeros(m,n); % 滤波后图像
    for i = r+1:m+r
        for j = r+1:n+r
            temp = f_temp(i-r:i+r,j-r:j+r);
            w_value = exp(-(temp - img(i-r,j-r)).^2/(2*sigma_r^2));  % size = (2r+1)*(2r+1)
            w = w_spacial .* w_value;
            s = temp.*w;
            b(i-r,j-r) = sum(s(:))/sum(w(:));  
        end
    end
end