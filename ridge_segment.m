function [normim, mask]=ridge_segment(img,blksze,thresh)
[rows,cols]=size(img);
im = normalise(img);
new_rows = int8(blksze * ceil((double(rows)) / (double(blksze))));
new_cols = int8(blksze * ceil((double(cols)) / (double(blksze))));
%padded_img = zeros(new_rows,new_cols);
stddevim = zeros(new_rows,new_cols);
padded_img=imresize(im,[new_rows,new_cols]);
for i=1:blksze:new_rows
    for j=1:blksze:new_cols
        block = padded_img(i:i + blksze, j:j + blksze);
        [r,c]=size(block);
        stddevim(i:i + blksze, j:j + blksze) = std2(block) * ones(r,c);
    end
end
stddevim = stddevim(1:new_rows, 1:new_cols);
mask = stddevim > thresh;
mean_val = mean(im(mask));
std_val = std(im(mask));
normim = (im - mean_val) / (std_val);
end
