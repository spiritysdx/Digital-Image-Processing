function res = bfilt_rgb(img,r,a,b)
% f�Ҷ�ͼ��r�˲��뾶��aȫ�ַ��b�ֲ�����

res = zeros(size(img)) ;
for ch = 1:3
     res(:,:,ch) = bfilt_gray(img(:,:,ch),r,a,b);
end

end