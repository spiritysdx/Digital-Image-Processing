function b = BF_Filter(img,r,sigma_d,sigma_r)
%% ����˵����˫���˲������ڼ���˫���˲����ͼ��
%          ˫���˲���һ�ַ����Է�����ͬʱ����ͼ��Ŀ�����Ϣ�ͻҶ������ԡ�
%          ͨ����������ֵ������γ��µ�Ȩ�ؾ������У������������ģ��ȥ�룬ֵ���������������Ե��
%% ���������img -- ���˲�ͼ��
%          r -- ģ��뾶��e.g. 3*3ģ��İ뾶Ϊ1
%          sigma_d -- ��������׼��
%          sigma_r -- ֵ������׼��
    
    % �ж��Ƿ�Ϊ�Ҷ�ͼ��
    if(size(img,3)>1)
        img = rgb2gray(img);
    end
    [x,y] = meshgrid(-r:r);
    
    % ����Ȩ�ؾ��� size = (2r+1)*(2r+1)
    w_spacial = exp(-(x.^2 + y.^2)/(2*sigma_d.^2));
 
    [m,n] = size(img);
    img = double(img);
    
    % ��չͼ��size = (m+2r)*(n+2r)
    f_temp = padarray(img,[r r],'symmetric');
    
    % �������ڲ��˲�
    b = zeros(m,n); % �˲���ͼ��
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